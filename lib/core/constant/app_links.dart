import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

import '../services/hive_services/box_kes.dart';
import '../../injection_container.dart';

class AppLinks {
  AppLinks._();

  // ============================== Server URL ==============================
  static final String server = dotenv.env['SERVER']!;
  // SERVER_TMMS for authentication endpoints
  static final String serverTMMS = dotenv.env['SERVER_TMMS'] ?? dotenv.env['SERVER']!;
  static final String chatChannel = dotenv.env['CHAT_CHANNEL']!;
  
  // ============================== Dynamic Server Selection ==============================
  /// Get server URL based on stored team selection
  /// Returns SERVER_TMMS for B2B Team, SERVER for WeFix Team
  /// Use this for Home, Profile, and Tickets pages
  static String getServerForTeam() {
    try {
      final userTeam = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
      return (userTeam == 'B2B Team') ? serverTMMS : server;
    } catch (e) {
      // Fallback to B2C server if team not found (shouldn't happen after login)
      return server;
    }
  }
  
  /// Get server URL based on provided team parameter
  /// Returns SERVER_TMMS for B2B Team, SERVER for WeFix Team
  /// Use this when team is available as a parameter (e.g., during login)
  static String getServerForTeamParam(String? team) {
    return (team == 'B2B Team') ? serverTMMS : server;
  }
  
  /// Always return B2C server (for pages that don't depend on team)
  static String getServerForCommon() {
    return server;
  }
  // ============================== Language ==============================
  static final String language = dotenv.env['LANGUAGE']!;
  // ============================== Auth ==============================
  static final String login = dotenv.env['LOGIN']!;
  static final String register = dotenv.env['REGISTER']!;
  static final String sendOTP = dotenv.env['SEND_OTP']!;
  static final String checkAccess = dotenv.env['CHECK_ACCESS']!;
  static final String profile = dotenv.env['PROFILE']!; 
   // ============================== Upload File ==============================
  static final String uploadFile = dotenv.env['UPLOAD_FILE']!;
  // ============================== Notification ==============================
  static final String notification = dotenv.env['NOTIFICATION']!;
  // ============================== Content ==============================
  static final String about = dotenv.env['ABOUT']!;
  static final String support = dotenv.env['SUPPORT']!;
  static final String contactInfo = dotenv.env['CONTACT_INFO']!;
  // ============================== Tools ==============================
  static final String tools = dotenv.env['TOOLS']!;
  static final String deleteTool = dotenv.env['DELETE_TOOL']!;
  // ============================== Home ==============================
  static final String home = dotenv.env['HOME']!;
  // ============================== Tickits ==============================
  static final String tickets = dotenv.env['TICKETS']!;
  static final String startTickets = dotenv.env['START_TICKETS']!;
  static final String completeTickets = dotenv.env['COMPLETE_TICKETS']!;
  static final String ticketsToolsList = dotenv.env['TICKETS_TOOLS_LIST']!;
  static final String ticketsMaterials = dotenv.env['TICKETS_MATERIALS']!;
  static final String ticketsAddTools = dotenv.env['TICKETS_ADD_TOOLS']!;
  static final String ticketsAddMaterials = dotenv.env['TICKETS_ADD_MATERIALS']!;
  static final String ticketsDeleteMaterials = dotenv.env['TICKETS_DELETE_MATERIALS']!;
  static final String type = dotenv.env['TYPE']!;
  static final String ticketsCreateMaintenances = dotenv.env['TICKETS_CREATE_MAINTENANCES']!;
  static final String unSelectMaintenances = dotenv.env['UN_SELETC_MAINTENANCES']!;
  static final String ticketsMaintenances = dotenv.env['TICKETS_MAINTENANCES']!;
  static final String ticketsAddMaintenances = dotenv.env['TICKETS_UPDATE_MAINTENANCES']!;
  static final String createTicketImage = dotenv.env['CREATE_TICKET_IMAGE']!;
  // ============================== Scan ==============================
  static final String scan = dotenv.env['SCAN']!;
  // ============================== Chat ==============================

  static final String chatSendMessage = dotenv.env['CHAT_SEND_MESSAGE']!;
  static final String chatGetMessages = dotenv.env['CHAT_GET_MESSAGES']!;
  
  // ============================== Token Management ==============================
  static final int tokenMinSessionLengthMinutes = int.parse(dotenv.env['TOKEN_MIN_SESSION_LENGTH_MINUTES'] ?? '30');
  static final int tokenValidityBufferSeconds = int.parse(dotenv.env['TOKEN_VALIDITY_BUFFER_SECONDS'] ?? '60');
  static final int tokenDefaultExpirationHours = int.parse(dotenv.env['TOKEN_DEFAULT_EXPIRATION_HOURS'] ?? '24');
  static final int tokenFallbackExpirationSeconds = int.parse(dotenv.env['TOKEN_FALLBACK_EXPIRATION_SECONDS'] ?? '3600');
  static final String tokenRefreshEndpoint = dotenv.env['TOKEN_REFRESH_ENDPOINT'] ?? 'user/refresh-token';
  static final String b2bTokenRefresh = dotenv.env['B2B_TOKEN_REFRESH'] ?? 'user/refresh-token';
  
  // ============================== B2B Routes (backend-tmms) ==============================
  // Auth Routes
  static final String b2bRequestOTP = dotenv.env['B2B_REQUEST_OTP'] ?? 'user/request-otp';
  static final String b2bVerifyOTP = dotenv.env['B2B_VERIFY_OTP'] ?? 'user/verify-otp';
  
  // User Routes
  static final String b2bUserProfile = dotenv.env['B2B_USER_PROFILE'] ?? 'user/profile';
  static final String b2bUserMe = dotenv.env['B2B_USER_ME'] ?? 'user/me';
  
  // Ticket Routes
  static final String b2bTicketsHome = dotenv.env['B2B_TICKETS_HOME'] ?? 'tickets/home';
  static final String b2bTicketsStart = dotenv.env['B2B_TICKETS_START'] ?? 'tickets/start';
  static final String b2bTicketsUpdate = dotenv.env['B2B_TICKETS_UPDATE'] ?? 'tickets'; // Base path, append /:id
  static final String b2bTicketsDetails = dotenv.env['B2B_TICKETS_DETAILS'] ?? 'tickets'; // Base path, append /:id
  
  // File Upload
  static final String b2bFilesUpload = dotenv.env['B2B_FILES_UPLOAD'] ?? 'files/upload';
  
  // Company Data Routes
  static final String b2bTicketStatuses = dotenv.env['B2B_TICKET_STATUSES'] ?? 'company-data/ticket-statuses';
  static final String b2bTicketTypes = dotenv.env['B2B_TICKET_TYPES'] ?? 'company-data/ticket-types';
  
  // Helper method to build ticket update URL
  static String b2bTicketUpdateUrl(String ticketId) {
    final base = b2bTicketsUpdate.endsWith('/') ? b2bTicketsUpdate.substring(0, b2bTicketsUpdate.length - 1) : b2bTicketsUpdate;
    return '$base/$ticketId';
  }
  
  // Helper method to build ticket details URL
  static String b2bTicketDetailsUrl(String ticketId) {
    final base = b2bTicketsDetails.endsWith('/') ? b2bTicketsDetails.substring(0, b2bTicketsDetails.length - 1) : b2bTicketsDetails;
    return '$base/$ticketId';
  }
  
  // ============================== App Store & Play Store ==============================
  static final String androidPackageName = dotenv.env['ANDROID_PACKAGE_NAME'] ?? 'com.tender.wefixsp.app';
  static final String iosBundleId = dotenv.env['IOS_BUNDLE_ID'] ?? 'com.tender.wefixsp.app';
  static String get playStoreUrl => dotenv.env['PLAY_STORE_URL'] ?? 'https://play.google.com/store/apps/details?id=$androidPackageName';
  static final String appStoreUrl = dotenv.env['APP_STORE_URL'] ?? 'https://apps.apple.com/us/app/wefix-technicians/id6749498779';
}
