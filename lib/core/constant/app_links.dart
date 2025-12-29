import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppLinks {
  AppLinks._();

  // ============================== Server URL ==============================
  static final String server = dotenv.env['SERVER']!;
  // SERVER_TMMS for authentication endpoints
  static final String serverTMMS = dotenv.env['SERVER_TMMS'] ?? dotenv.env['SERVER']!;
  static final String chatChannel = dotenv.env['CHAT_CHANNEL']!;
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
}
