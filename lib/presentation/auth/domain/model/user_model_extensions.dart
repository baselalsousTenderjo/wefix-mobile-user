import 'user_model.dart';

/// Extension methods for User model to provide easy access to synchronized fields
/// These methods prefer backend fields (fullName, mobileNumber, profileImage) 
/// while falling back to legacy fields for backward compatibility
extension UserModelExtensions on User {
  /// Get display name - prefers fullName/fullNameEnglish, falls back to name
  String? get displayName {
    // Prefer fullNameEnglish for English, fullName for Arabic
    // Fall back to legacy 'name' field if new fields are not available
    return fullNameEnglish ?? fullName ?? name;
  }

  /// Get display name in Arabic - prefers fullName, falls back to name
  String? get displayNameAr {
    return fullName ?? name;
  }

  /// Get mobile number - prefers mobileNumber, falls back to mobile
  String? get displayMobile {
    return mobileNumber ?? mobile;
  }

  /// Get profile image - prefers profileImage, falls back to image
  String? get displayImage {
    return profileImage ?? image;
  }

  /// Get full mobile number with country code
  String? get fullMobileNumber {
    if (mobileNumber != null && countryCode != null) {
      return '$countryCode$mobileNumber';
    }
    return displayMobile;
  }
}


