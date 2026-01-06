import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:go_router/go_router.dart';

import '../../constant/app_links.dart';
import '../../context/global.dart';
import '../../services/api_services/api_client.dart';
import '../../services/api_services/dio_helper.dart';
import '../../services/hive_services/box_kes.dart';
import '../../router/router_key.dart';
import '../../../injection_container.dart';
import 'token_utils.dart';

/// Refresh promise to prevent multiple simultaneous refresh calls
Future<bool>? _refreshPromise;

/// Helper method to check if user is B2B Team
Future<bool> _isB2BTeam() async {
  try {
    final userTeam = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
    return userTeam == 'B2B Team';
  } catch (e) {
    return false;
  }
}

/// Refreshes the access token using the refresh token
/// Returns true if successful, false otherwise
Future<bool> refreshAccessToken() async {
  // If there's already a refresh in progress, wait for it
  if (_refreshPromise != null) {
    return _refreshPromise!;
  }

  _refreshPromise = (() async {
    try {
      final box = sl<Box>(instanceName: BoxKeys.appBox);
      final refreshToken = box.get('${BoxKeys.usertoken}_refresh');

      if (refreshToken == null || refreshToken.toString().isEmpty) {
        log('No refresh token available');
        return false;
      }

      // Call refresh token API using team-based server
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      
      // Use B2B route for B2B Team, B2C route for WeFix Team
      final bool isB2B = await _isB2BTeam();
      final String endpoint = isB2B ? AppLinks.b2bTokenRefresh : AppLinks.tokenRefreshEndpoint;
      
      final response = await client.postRequest(
        endpoint: endpoint,
        body: {'refreshToken': refreshToken},
      );

      if (response.response.statusCode == 200) {
        final responseData = response.response.data;
        final newAccessToken = responseData['token']?['accessToken'] ?? responseData['accessToken'];
        final newRefreshToken = responseData['token']?['refreshToken'] ?? responseData['refreshToken'];
        final expiresIn = responseData['token']?['expiresIn'] ?? responseData['expiresIn'];

        if (newAccessToken != null) {
          // Save new tokens
          await box.put(BoxKeys.usertoken, newAccessToken);
          if (newRefreshToken != null) {
            await box.put('${BoxKeys.usertoken}_refresh', newRefreshToken);
          }

          // Calculate and save expiration time
                if (expiresIn != null) {
                  final expiresInSeconds = expiresIn is int 
                      ? expiresIn 
                      : int.tryParse(expiresIn.toString()) ?? AppLinks.tokenFallbackExpirationSeconds;
                  final tokenExpiresAt = DateTime.now().add(Duration(seconds: expiresInSeconds));
                  await box.put('${BoxKeys.usertoken}_expiresAt', tokenExpiresAt.toIso8601String());
                }

          log('Token refreshed successfully');
          return true;
        }
      }

      log('Token refresh failed: ${response.response.statusCode}');
      return false;
    } catch (e) {
      log('Token refresh error: $e');
      return false;
    } finally {
      _refreshPromise = null;
    }
  })();

  return _refreshPromise!;
}

/// Get token expiration time from storage
DateTime? getTokenExpiresAt() {
  try {
    final box = sl<Box>(instanceName: BoxKeys.appBox);
    final expiresAtString = box.get('${BoxKeys.usertoken}_expiresAt');
    if (expiresAtString != null && expiresAtString.toString().isNotEmpty) {
      return DateTime.parse(expiresAtString.toString());
    }
  } catch (e) {
    log('Error getting token expiration: $e');
  }
  return null;
}

/// Checks if token needs refresh and refreshes it if needed
/// Should be called before making authenticated requests
/// Returns true if token is valid or refreshed successfully, false otherwise
Future<bool> ensureValidToken() async {
  try {
    final box = sl<Box>(instanceName: BoxKeys.appBox);
    final token = box.get(BoxKeys.usertoken);

    // If no token, token is invalid
    if (token == null || token.toString().isEmpty) {
      return false;
    }

    // Get token expiration date
    DateTime? tokenExpiresAt = getTokenExpiresAt();

    // If tokenExpiresAt is null but we have refresh token, try to refresh token
    // This handles the case where token was loaded from cache but tokenExpiresAt was not saved/loaded properly
    if (tokenExpiresAt == null) {
      final refreshToken = box.get('${BoxKeys.usertoken}_refresh');
      if (refreshToken != null && refreshToken.toString().isNotEmpty) {
        final refreshed = await refreshAccessToken();
        if (refreshed) {
          tokenExpiresAt = getTokenExpiresAt();
        } else {
          return false;
        }
      } else {
        // No expiration info and no refresh token - assume token is valid for now
        // But mark it as needing refresh on next API call
        return true;
      }
    }

    // If no token expiration after refresh attempt, can't determine validity
    if (tokenExpiresAt == null) {
      return true; // Assume valid if we can't determine
    }

    // Check if token is expired
    if (!isTokenValid(tokenExpiresAt)) {
      // Token expired - try to refresh
      final refreshToken = box.get('${BoxKeys.usertoken}_refresh');
      if (refreshToken != null && refreshToken.toString().isNotEmpty) {
        log('Token expired, attempting refresh...');
        final refreshed = await refreshAccessToken();
        
        if (!refreshed) {
          // Refresh failed - force logout
          await _forceLogout();
          return false;
        }
        
        return true;
      } else {
        // No refresh token - force logout
        await _forceLogout();
        return false;
      }
    }

    // Check if token should be refreshed (less than 30 minutes remaining)
    if (shouldRefreshToken(tokenExpiresAt)) {
      // Refresh token
      final refreshed = await refreshAccessToken();
      
      if (!refreshed) {
        // Refresh failed - but token is still valid, so continue
        // Don't force logout yet, let the next expired check handle it
        log('Token refresh failed but token still valid');
        return true;
      }
      
      return true;
    }
    
    // Token is valid and doesn't need refresh
    return true;
  } catch (e) {
    log('Error ensuring valid token: $e');
    return false;
  }
}

/// Force logout user when token expires or refresh fails
Future<void> _forceLogout() async {
  try {
    // Schedule logout after current frame is built to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final box = sl<Box>(instanceName: BoxKeys.appBox);
        final userBox = sl<Box>(instanceName: BoxKeys.userData);
        
        // Clear all user data and tokens
        await box.delete(BoxKeys.usertoken);
        await box.delete('${BoxKeys.usertoken}_refresh');
        await box.delete('${BoxKeys.usertoken}_expiresAt');
        await box.delete(BoxKeys.enableAuth);
        await box.delete(BoxKeys.userTeam);
        await userBox.delete(BoxKeys.userData);

        // Navigate to login screen
        final context = GlobalContext.context;
        if (context.mounted) {
          context.go(RouterKey.login);
        }
      } catch (e) {
        log('Error during force logout: $e');
      }
    });
  } catch (e) {
    log('Error scheduling force logout: $e');
  }
}

