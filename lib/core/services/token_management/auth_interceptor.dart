import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../services/hive_services/box_kes.dart';
import '../../services/token_management/token_refresh.dart';
import '../../services/token_management/force_logout.dart';
import '../../../injection_container.dart';

/// Dio interceptor to handle token refresh and 401/403 responses
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Skip token check for login/refresh endpoints
      if (options.path.contains('login') || 
          options.path.contains('request-otp') || 
          options.path.contains('verify-otp') ||
          options.path.contains('refresh-token')) {
        return handler.next(options);
      }

      // Ensure token is valid before making request
      final isValid = await ensureValidToken();
      if (!isValid) {
        // Token is invalid and couldn't be refreshed
        // The force logout will be handled in token_refresh.dart
        return handler.next(options);
      }

      // Get token from storage
      final box = sl<Box>(instanceName: BoxKeys.appBox);
      final token = box.get(BoxKeys.usertoken);
      
      // Add token to request if available
      if (token != null && token.toString().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      log('Error in AuthInterceptor onRequest: $e');
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized and 403 Forbidden responses
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      try {
        // Skip for login/refresh endpoints
        if (err.requestOptions.path.contains('login') || 
            err.requestOptions.path.contains('request-otp') || 
            err.requestOptions.path.contains('verify-otp') ||
            err.requestOptions.path.contains('refresh-token')) {
          return handler.next(err);
        }

        // Check if user account is deactivated - force logout immediately without refresh attempt
        final responseData = err.response?.data;
        if (responseData is Map && responseData['message'] == 'User account is deactivated') {
          log('User account is deactivated - forcing logout');
          await forceLogout();
          return handler.next(err);
        }

        // Try to refresh token
        final refreshed = await refreshAccessToken();
        
        if (refreshed) {
          // Retry the original request with new token
          final box = sl<Box>(instanceName: BoxKeys.appBox);
          final newToken = box.get(BoxKeys.usertoken);
          
          if (newToken != null && newToken.toString().isNotEmpty) {
            // Update the request with new token
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            
            // Retry the request
            try {
              final response = await Dio().fetch(err.requestOptions);
              return handler.resolve(response);
            } catch (e) {
              // Retry failed, proceed with error
              return handler.next(err);
            }
          }
        }
        
        // Refresh failed or no token - the force logout will be handled in token_refresh.dart
        // Don't retry, let the error propagate
      } catch (e) {
        log('Error in AuthInterceptor onError: $e');
      }
    }
    
    handler.next(err);
  }
}

