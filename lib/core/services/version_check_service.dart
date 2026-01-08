import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dio/dio.dart';
import '../constant/app_links.dart';

class VersionCheckService {
  // Package names and store URLs from AppLinks (loaded from .env)
  static String get androidPackageName => AppLinks.androidPackageName;
  static String get iosBundleId => AppLinks.iosBundleId;
  static String get playStoreUrl => AppLinks.playStoreUrl;
  static String get appStoreUrl => AppLinks.appStoreUrl;
  
  /// Get current app version
  static Future<String> getCurrentVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (e) {
      return '1.0.0';
    }
  }
  
  /// Check if update is needed by comparing with store version
  /// Returns true if update is needed, false otherwise
  static Future<bool> checkForUpdate() async {
    try {
      final currentVersion = await getCurrentVersion();
      String? storeVersion;
      
      if (Platform.isAndroid) {
        storeVersion = await getPlayStoreVersion(androidPackageName);
      } else if (Platform.isIOS) {
        storeVersion = await getAppStoreVersion(iosBundleId);
      }
      
      if (storeVersion == null) {
        // If we can't get store version, allow app to continue
        return false;
      }
      
      return _compareVersions(currentVersion, storeVersion) < 0;
    } catch (e) {
      // On error, allow app to continue
      return false;
    }
  }
  
  /// Get version from Play Store
  static Future<String?> getPlayStoreVersion(String packageName) async {
    try {
      final dio = Dio();
      final url = 'https://play.google.com/store/apps/details?id=$packageName';
      final response = await dio.get(url);
      
      if (response.statusCode == 200) {
        // Parse HTML to find version
        final html = response.data.toString();
        // Look for version pattern in HTML
        final versionMatch = RegExp(r'Current Version</div><span[^>]*>([^<]+)</span>')
            .firstMatch(html);
        if (versionMatch != null) {
          return versionMatch.group(1)?.trim();
        }
        
        // Alternative pattern
        final altMatch = RegExp(r'"version":"([^"]+)"').firstMatch(html);
        if (altMatch != null) {
          return altMatch.group(1)?.trim();
        }
      }
    } catch (e) {
      // If Play Store check fails, try alternative method
      return await _getPlayStoreVersionAlternative(packageName);
    }
    return null;
  }
  
  /// Alternative method to get Play Store version using unofficial API
  static Future<String?> _getPlayStoreVersionAlternative(String packageName) async {
    try {
      final dio = Dio();
      // Using an alternative API endpoint
      final url = 'https://play.google.com/store/apps/details?id=$packageName&hl=en';
      final response = await dio.get(url);
      
      if (response.statusCode == 200) {
        final html = response.data.toString();
        // Try different patterns
        final patterns = [
          RegExp(r'Current Version</div><span[^>]*>([^<]+)</span>'),
          RegExp(r'"version":"([^"]+)"'),
          RegExp(r'Version</div><span[^>]*>([^<]+)</span>'),
        ];
        
        for (var pattern in patterns) {
          final match = pattern.firstMatch(html);
          if (match != null) {
            return match.group(1)?.trim();
          }
        }
      }
    } catch (e) {
      // Silently fail
    }
    return null;
  }
  
  /// Get version from App Store
  static Future<String?> getAppStoreVersion(String bundleId) async {
    try {
      final dio = Dio();
      // App Store API endpoint
      final url = 'https://itunes.apple.com/lookup?bundleId=$bundleId';
      final response = await dio.get(url);
      
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null && data['results'].isNotEmpty) {
          return data['results'][0]['version'] as String?;
        }
      }
    } catch (e) {
      // Silently fail
    }
    return null;
  }
  
  /// Compare two version strings
  /// Returns: -1 if version1 < version2, 0 if equal, 1 if version1 > version2
  static int _compareVersions(String version1, String version2) {
    final v1Parts = version1.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final v2Parts = version2.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    
    // Pad with zeros to make same length
    while (v1Parts.length < v2Parts.length) v1Parts.add(0);
    while (v2Parts.length < v1Parts.length) v2Parts.add(0);
    
    for (int i = 0; i < v1Parts.length; i++) {
      if (v1Parts[i] < v2Parts[i]) return -1;
      if (v1Parts[i] > v2Parts[i]) return 1;
    }
    return 0;
  }
  
  /// Get store URL based on platform
  static String getStoreUrl() {
    if (Platform.isAndroid) {
      return AppLinks.playStoreUrl;
    } else if (Platform.isIOS) {
      return AppLinks.appStoreUrl;
    }
    return '';
  }
}
