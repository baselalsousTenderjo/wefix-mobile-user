// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request Cancelled');

      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection Timeout');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive Timeout');

      case DioExceptionType.badResponse:
        // Extract message from response data
        String? errorMessage;
        final responseData = dioException.response?.data;
        if (responseData is Map) {
          errorMessage = responseData['message']?.toString();
          // Also check for other common error message fields
          if ((errorMessage == null || errorMessage.isEmpty) && responseData.containsKey('error')) {
            errorMessage = responseData['error']?.toString();
          }
          if ((errorMessage == null || errorMessage.isEmpty) && responseData.containsKey('msg')) {
            errorMessage = responseData['msg']?.toString();
          }
        } else if (responseData != null) {
          errorMessage = responseData.toString();
        }
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          message: errorMessage,
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send Timeout');

      case DioExceptionType.connectionError:
        return ServerFailure(message: 'Connection Error');

      default:
        return ServerFailure(message: 'Unknown Error');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, {String? message}) {
    switch (statusCode) {
      case 400:
        return ServerFailure(message: message ?? 'Bad Request');
      case 401:
        return ServerFailure(message: message ?? 'Unauthorized');
      case 403:
        return ServerFailure(message: message ?? 'Forbidden');
      case 404:
        return ServerFailure(message: message ?? 'Not Found');
      case 422:
        return ServerFailure(message: message ?? 'Unprocessable Entity');
      case 500:
        return ServerFailure(message: message ?? 'Internal Server Error');
      case 502:
        return ServerFailure(message: message ?? 'Bad Gateway');
      default:
        return ServerFailure(message: message ?? 'Unknown Error');
    }
  }

  @override
  String toString() => message;
}
