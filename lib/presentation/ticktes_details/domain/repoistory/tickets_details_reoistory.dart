import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/errors/dio_exp.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_services/api_client.dart';
import '../../../../core/services/api_services/dio_helper.dart';
import '../../../../core/services/api_services/result_model.dart';
import '../../../../core/services/hive_services/box_kes.dart';
import '../../../../injection_container.dart';
import '../model/tickets_details_model.dart';

abstract class TicketsDetailsReoistory {
  Future<Either<Failure, Result<TicketsDetails>>> ticketDetails(String ticketId);
  Future<Either<Failure, Result<Unit>>> startTickets(String ticketId);
  Future<Either<Failure, Result<Unit>>> startTicketsWithAttachment(String ticketId, String attachmentUrl);
  Future<Either<Failure, Result<Unit>>> createTicketImage(String ticketId, List<String> images);
  Future<Either<Failure, Result<Unit>>> completeTicket(String ticketId, String note, String signature, String link);
}

class TicketsDetailsReoistoryImpl implements TicketsDetailsReoistory {
  // Helper method to check if user is B2B Team
  Future<bool> _isB2BTeam() async {
    try {
      final userTeam = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
      return userTeam == 'B2B Team';
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, Result<TicketsDetails>>> ticketDetails(String ticketId) async {
    try {
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      
      // Use B2B route for B2B Team, B2C route for WeFix Team
      final String endpoint = (await _isB2BTeam()) 
          ? AppLinks.b2bTicketDetailsUrl(ticketId) 
          : '${AppLinks.tickets}$ticketId';
      final ticketDetailsResponse = await client.getRequest(endpoint: endpoint, authorization: 'Bearer $token');
      
      // Handle both direct data and wrapped response formats
      final responseData = ticketDetailsResponse.response.data;
      
      // B2B API returns { objTickets: {...} }, B2C might return { data: {...} } or direct {...}
      final data = responseData['data'] ?? responseData;
      
      TicketsDetailsModel ticketDetails = TicketsDetailsModel.fromJson(data);
      return Right(Result.success(ticketDetails.ticketsDetails));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<Unit>>> startTickets(String ticketId) async {
    try {
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      
      final bool isB2B = await _isB2BTeam();
      // Use B2B route for B2B Team, B2C route for WeFix Team
      final String endpoint = isB2B ? AppLinks.b2bTicketsStart : AppLinks.startTickets;
      
      // B2B: Send empty attachmentUrl to indicate no attachment (optional for B2B only)
      // B2C: Keep original behavior (no attachmentUrl field)
      final Map<String, dynamic> body = {
        'Id': ticketId,
      };
      
      if (isB2B) {
        // Only add attachmentUrl for B2B (optional)
        body['attachmentUrl'] = '';
      }
      
      await client.postRequest(
        endpoint: endpoint, 
        body: body, 
        authorization: 'Bearer $token'
      );
      return Right(Result.success(unit));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<Unit>>> startTicketsWithAttachment(String ticketId, String attachmentUrl) async {
    try {
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      
      // Use B2B route for B2B Team, B2C route for WeFix Team
      final String endpoint = (await _isB2BTeam()) ? AppLinks.b2bTicketsStart : AppLinks.startTickets;
      
      // The attachment is already uploaded via authUsecase.uploadFile
      // Pass the attachmentUrl directly to startTicket endpoint
      // The startTicket endpoint will create a File record linking it to the ticket
      await client.postRequest(
        endpoint: endpoint, 
        body: {
          'Id': ticketId,
          'attachmentUrl': attachmentUrl, // Pass attachment URL to startTicket endpoint
        }, 
        authorization: 'Bearer $token'
      );
      return Right(Result.success(unit));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<Unit>>> completeTicket(String ticketId, String note, String signature, String link) async {
    try {
      final bool isB2B = await _isB2BTeam();
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      
      if (isB2B) {
        // B2B: Backend-tmms route: PUT /api/v1/tickets/:id (update ticketStatusId to "Completed")
        // First, get ticket statuses to find "Completed" status ID
        final String statusesEndpoint = AppLinks.b2bTicketStatuses;
        final statusesResponse = await client.getRequest(endpoint: statusesEndpoint, authorization: 'Bearer $token');
        final statuses = statusesResponse.response.data['data'] ?? statusesResponse.response.data;
        final completedStatus = (statuses as List).firstWhere(
          (status) => (status['name'] as String?)?.toLowerCase() == 'completed',
          orElse: () => null,
        );
        
        if (completedStatus == null) {
          return Left(ServerFailure(message: 'Completed status not found'));
        }
        
        final completedStatusId = completedStatus['id'] as int;
        
        // Update ticket with completed status, note, and signature
        final String updateEndpoint = AppLinks.b2bTicketUpdateUrl(ticketId);
        await client.putRequest(
          endpoint: updateEndpoint,
          body: {
            'ticketStatusId': completedStatusId,
            'serviceDescription': note, // Store note in serviceDescription
            'signatureUrl': signature, // Pass signature URL to link it to ticket
          },
          authorization: 'Bearer $token',
        );
      } else {
        // B2C: Backend-tjms route: POST /ServiceProvider/CompleteTickets
        // Body: { Id, SpNote, Signature, VideoLink }
        final String completeEndpoint = AppLinks.completeTickets;
        await client.postRequest(
          endpoint: completeEndpoint,
          body: {
            'Id': int.tryParse(ticketId) ?? ticketId, // Ticket ID as integer
            'SpNote': note, // Service provider note
            'Signature': signature, // Signature (base64 or URL)
            'VideoLink': link, // Video link if available
          },
          authorization: 'Bearer $token',
        );
      }
      
      return Right(Result.success(unit));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<Unit>>> createTicketImage(String ticketId, List<String> images) async {
    try {
      // Use SERVER_TMMS for create ticket image endpoint (backend-tmms)
      // Backend-tmms route: POST /api/v1/files/upload (for each image)
      // Files are automatically linked to tickets via entityId and entityType
      if (images.isEmpty) {
        return Right(Result.success(unit));
      }
      
      final dio = DioProvider().dio;
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      final baseUrl = AppLinks.getServerForTeam();
      
      // Upload each image
      for (String imagePath in images) {
        // Check if imagePath is a file path or URL
        File? imageFile;
        
        if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
          // If it's a URL, download it first
          final response = await dio.get(
            imagePath,
            options: Options(responseType: ResponseType.bytes),
          );
          
          // Create a temporary file
          final tempDir = Directory.systemTemp;
          final tempFile = File('${tempDir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.jpg');
          await tempFile.writeAsBytes(response.data);
          imageFile = tempFile;
        } else {
          // If it's a file path, use it directly
          imageFile = File(imagePath);
          if (!await imageFile.exists()) {
            continue; // Skip if file doesn't exist
          }
        }
        
        // Create FormData with file and referenceId
        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
          'referenceId': ticketId,
          'referenceType': 'TICKET_ATTACHMENT',
          'entityType': 'ticket',
        });
        
        // Use B2B route for B2B Team, B2C route for WeFix Team
        final String uploadEndpoint = (await _isB2BTeam()) ? AppLinks.b2bFilesUpload : AppLinks.uploadFile;
        final uploadUrl = baseUrl.endsWith('/') 
            ? '$baseUrl$uploadEndpoint'
            : '$baseUrl/$uploadEndpoint';
        
        await dio.post(
          uploadUrl,
          data: formData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        
        // Clean up temporary file if it was downloaded
        if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
          try {
            await imageFile.delete();
          } catch (e) {
            // Ignore cleanup errors
          }
        }
      }
      
      return Right(Result.success(unit));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
