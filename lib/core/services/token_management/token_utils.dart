import '../../constant/app_links.dart';

/// Minimum session length before token expiration to trigger refresh
int get minSessionLengthMs => AppLinks.tokenMinSessionLengthMinutes * 60 * 1000;

/// Check if token is valid (not expired)
/// Token is valid if it hasn't expired yet (with configurable buffer)
bool isTokenValid(DateTime? tokenExpiresAt) {
  if (tokenExpiresAt == null) {
    return false;
  }

  final now = DateTime.now();
  final diff = tokenExpiresAt.difference(now).inMilliseconds;

  // Token is valid if it hasn't expired yet (with configurable buffer)
  final bufferMs = AppLinks.tokenValidityBufferSeconds * 1000;
  return diff > bufferMs;
}

/// Check if token should be refreshed
/// Token should be refreshed if less than 30 minutes remaining but not expired yet
bool shouldRefreshToken(DateTime? tokenExpiresAt) {
  if (tokenExpiresAt == null) {
    return false;
  }

  final now = DateTime.now();
  final diff = tokenExpiresAt.difference(now).inMilliseconds;

  // Should refresh if less than configured minutes remaining but not expired yet
  // diff > 0 means token is not expired yet
  // diff < minSessionLengthMs means less than configured minutes remaining
  return diff > 0 && diff < minSessionLengthMs;
}

/// Get time remaining until token expires (in milliseconds)
/// Returns 0 if expired or not set
int getTimeRemaining(DateTime? tokenExpiresAt) {
  if (tokenExpiresAt == null) {
    return 0;
  }

  final now = DateTime.now();
  final diff = tokenExpiresAt.difference(now).inMilliseconds;

  return diff > 0 ? diff : 0;
}

