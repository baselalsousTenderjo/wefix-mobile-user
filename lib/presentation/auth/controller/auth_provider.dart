import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/constant/app_links.dart';
import '../../../core/context/global.dart';
import '../../../core/extension/gap.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/router/router_key.dart';
import '../../../core/services/hive_services/box_kes.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/widget_daialog.dart';
import '../../../injection_container.dart';
import '../domain/auth_enum.dart';
import '../domain/model/contact_info_model.dart';
import '../domain/model/job_application_params.dart';
import '../domain/model/user_model.dart';
import '../domain/usecase/auth_usecase.dart';

class AuthProvider extends ChangeNotifier with WidgetsBindingObserver {
  final AuthUsecase authUsecase;

  bool isRegister = false;

  // Team selection: B2B Team (default) or WeFix Team
  String selectedTeam = 'B2B Team'; // Default to B2B Team

  // Auth  Variables
  final key = GlobalKey<FormState>();
  final keyRegister = GlobalKey<FormState>();
  final otpKey = GlobalKey<FormState>();
  final ValueNotifier<LoginState> loginState = ValueNotifier(LoginState.init);
  final ValueNotifier<SendState> sendOTPState = ValueNotifier(SendState.init);
  final ValueNotifier<UploadFileState> uploadState = ValueNotifier(UploadFileState.init);
  TextEditingController mobile = TextEditingController();
  TextEditingController digitCode = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController intro = TextEditingController();
  TextEditingController cv = TextEditingController();

  final LocalAuthentication authFingerPrint = LocalAuthentication();
  bool isSupport = false;
  bool isFaceIdEnabled = false;
  final ImagePicker _picker = ImagePicker();
  File? imagePath;
  String? image;
  File? filePath;
  Timer? timer;
  Map audioRecord = {'path': '', 'duration': 0, 'stop': false};
  String? audio;
  int duration = 0;
  final record = AudioRecorder();
  bool isRecording = false;

  AuthProvider({required this.authUsecase}) {
    Future.wait([isBiometricAuthAvailable(), getContactInfo(), checkBiometrics()]);
  }

  final ValueNotifier<ContactInfoModel> contractInfo = ValueNotifier(const ContactInfoModel());

  Future<void> getContactInfo() async {
    try {
      final contactInfoResponse = await authUsecase.getContactInfo();
      contactInfoResponse.fold(
        (l) {
          log('Error fetching contact info: ${l.message}');
        },
        (r) {
          contractInfo.value = r.data!;
          log('Contact info fetched successfully: ${r.data}');
        },
      );
    } catch (e) {
      log('Exception while fetching contact info: $e');
    }
  }

  // Enter Mobile Number Method
  void enterPhoneNumber(PhoneNumber phoneNumber) {
    mobile.text = phoneNumber.phoneNumber ?? '';
    notifyListeners();
  }

  // Function to change the authentication type
  void toggleAuth() {
    isRegister = !isRegister;
    notifyListeners();
  }

  // Support Show Dialogs
  void supportDailg(BuildContext context) {
    SmartDialog.show(
      builder:
          (context) => WidgetDilog(
            title: AppText(context).support,
            message: '',
            isSupport: true,
            contents: [
              Text(AppText(context).pleasecontactthedirectengineerorphonenumber, textAlign: TextAlign.center, style: AppTextStyle.style14),
              5.gap,
              Center(
                child: InkWell(
                  onTap: () async {
                    const url = 'tel:00962780000000';
                    final uri = Uri.parse(url);
                    await launchUrl(uri);
                  },
                  child: Text('+962780000000', style: AppTextStyle.style14B.copyWith(color: AppColor.primaryColor)),
                ),
              ),
            ],
            cancelText: AppText(context).cancel,
            onCancel: () {
              SmartDialog.dismiss();
            },
          ),
    );
  }

  // Start Recording Function
  Future<void> startRecording() async {
    final micStatus = await Permission.microphone.request();

    if (micStatus.isGranted) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        final path = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";

        await record.start(const RecordConfig(), path: path);
        audioRecord['path'] = path.split('/').last;
        isRecording = true;
        _startTimer();
        notifyListeners();
      } catch (e) {
        log("Error starting recording: $e");
      }
    } else if (micStatus.isPermanentlyDenied) {
      log("Microphone permission is permanently denied. Redirecting to settings...");
      await openAppSettings();
    } else {
      log("Microphone permission was denied.");
    }
  }

  Future<void> stopRecording() async {
    try {
      await record.stop();
    } catch (e) {
      log("Error stopping recording: $e");
    } finally {
      isRecording = false;
      duration = 0;
      audioRecord['duration'] = duration;
      audioRecord['stop'] = true;
      _stopTimer();
      uploadFile(UploadFileType.voice);
      notifyListeners();
    }
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration = duration + 1;
      notifyListeners();
    });
  }

  void _stopTimer() {
    timer?.cancel();
    timer = null;
  }

  void clearAudioRecord() {
    audioRecord = {'path': '', 'duration': 0, 'stop': false};
    notifyListeners();
  }

  // Social Media Links Function
  void launchSocial(String link) async {
    final url = Uri.parse(link);
    await launchUrl(url);
  }

  // Login Function
  Future<void> login() async {
    if (key.currentState!.validate()) {
      try {
        loginState.value = LoginState.loading;
        
        // Normalize phone number - the phone widget should already provide international format
        String normalizedMobile = mobile.text.replaceAll(' ', '').replaceAll('-', '').trim();
        
        // Validate that it has country code
        if (!normalizedMobile.startsWith('+')) {
          loginState.value = LoginState.failure;
          SmartDialog.show(
            builder:
                (context) => WidgetDilog(
                  isError: true,
                  title: AppText(context).warning,
                  message: AppText(context).pleaseEnterPhoneWithCountryCode,
                  cancelText: AppText(context).back,
                  onCancel: () => SmartDialog.dismiss(),
                ),
          );
          return;
        }
        
        final loginRequiest = await authUsecase.login(mobile: normalizedMobile, team: selectedTeam);
        loginRequiest.fold(
          (l) {
            loginState.value = LoginState.failure;
            
            SmartDialog.show(
              builder:
                  (context) {
                    // Provide more specific error messages using localized strings
                    String errorMessage = l.message.isNotEmpty ? l.message : AppText(context).anErrorOccurred;
                    
                    // Try to get localized versions if the message matches known patterns
                    if (errorMessage.toLowerCase().contains('does not exist') || 
                        errorMessage.toLowerCase().contains('account does not exist')) {
                      final localized = AppText(context).accountDoesNotExist;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('invalid format') || 
                               errorMessage.toLowerCase().contains('phone number')) {
                      final localized = AppText(context).invalidPhoneNumberFormat;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('locked')) {
                      final localized = AppText(context).accountTemporarilyLocked;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('wait') || 
                               errorMessage.toLowerCase().contains('rate')) {
                      final localized = AppText(context).pleaseWaitBeforeRequestingOTP;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('internal server error') ||
                               errorMessage.toLowerCase().contains('500')) {
                      final localized = AppText(context).internalServerError;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('bad request') ||
                               errorMessage.toLowerCase().contains('400')) {
                      final localized = AppText(context).badRequest;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('unauthorized') ||
                               errorMessage.toLowerCase().contains('401')) {
                      final localized = AppText(context).unauthorized;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('forbidden') ||
                               errorMessage.toLowerCase().contains('403')) {
                      final localized = AppText(context).forbidden;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('not found') ||
                               errorMessage.toLowerCase().contains('404')) {
                      final localized = AppText(context).notFound;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('connection error')) {
                      final localized = AppText(context).connectionError;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('connection timeout')) {
                      final localized = AppText(context).connectionTimeout;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('unknown error')) {
                      final localized = AppText(context).unknownError;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('failed to send')) {
                      final localized = AppText(context).failedToSendOTP;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    }
                    
                    // Ensure message is never empty - use localized fallback
                    if (errorMessage.isEmpty) {
                      errorMessage = AppText(context).anErrorOccurred;
                    }
                    
                    return WidgetDilog(
                      isError: true,
                      title: AppText(context).warning,
                      message: errorMessage,
                      cancelText: AppText(context).back,
                      onCancel: () => SmartDialog.dismiss(),
                    );
                  },
            );
          },
          (r) {
            loginState.value = LoginState.success;
            // Pass normalized mobile to OTP screen
            String normalizedMobile = mobile.text.replaceAll(' ', '').replaceAll('-', '').trim();
            
            // Get OTP from response if available (for development/testing)
            String? otpFromResponse;
            final responseData = r.data;
            if (responseData != null && responseData.containsKey('otp')) {
              otpFromResponse = responseData['otp']?.toString();
            }
            
            // Build URL with mobile and optional OTP
            String otpUrl = '${RouterKey.login + RouterKey.otp}?mobile=${Uri.encodeComponent(normalizedMobile)}';
            if (otpFromResponse != null) {
              otpUrl += '&otp=${Uri.encodeComponent(otpFromResponse)}';
            }
            
            return GlobalContext.context.push(otpUrl);
          },
        );
      } catch (e) {
        loginState.value = LoginState.failure;
        log('Server Error In Login Section : $e');
        SmartDialog.show(
          builder:
              (context) => WidgetDilog(
                isError: true,
                title: AppText(context).warning,
                message: 'Network or service error. Please try again',
                cancelText: AppText(context).back,
                onCancel: () => SmartDialog.dismiss(),
              ),
        );
      }
    }
  }

  // Register Functions
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = File(pickedFile.path);
      await uploadFile(UploadFileType.image);
    }
    notifyListeners();
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      filePath = File(result.files.single.path!);
      await uploadFile(UploadFileType.cv);
    }
    notifyListeners();
  }

  Future<void> uploadFile(UploadFileType fileType) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      File? fileToUpload;

      switch (fileType) {
        case UploadFileType.image:
          if (imagePath != null) fileToUpload = imagePath;
          break;
        case UploadFileType.voice:
          final voiceFilePath = audioRecord['path'];
          if (voiceFilePath != null) fileToUpload = File('${dir.path}/$voiceFilePath');
          break;
        case UploadFileType.cv:
          if (filePath != null) fileToUpload = filePath;
          break;
      }

      if (fileToUpload == null) {
        throw Exception('No valid file found to upload.');
      }

      final result = await authUsecase.uploadFile(fileToUpload);

      result.fold(
        (failure) {
          uploadState.value = UploadFileState.failure;
          SmartDialog.show(
            builder:
                (context) => WidgetDilog(
                  isError: true,
                  title: AppText(context).warning,
                  message: failure.message,
                  cancelText: AppText(context).back,
                  onCancel: () => SmartDialog.dismiss(),
                ),
          );
        },
        (success) {
          uploadState.value = UploadFileState.success;

          switch (fileType) {
            case UploadFileType.image:
              image = success.data!;
              log('Uploaded image: $image');
              break;
            case UploadFileType.voice:
              audio = success.data!;
              log('Uploaded audio: $audio');
              break;
            case UploadFileType.cv:
              cv.text = success.data!;
              log('Uploaded CV: ${cv.text}');
              break;
          }

          notifyListeners();
        },
      );
    } catch (e, stack) {
      uploadState.value = UploadFileState.failure;
      log('Upload error: $e\n$stack');
    }
  }

  Future<void> register() async {
    if (keyRegister.currentState!.validate()) {
      try {
        loginState.value = LoginState.loading;
        Map<String, dynamic> userData = {
          'Name': name.text,
          'Email': email.text,
          'Mobile': digitCode.text + mobile.text,
          'Address': address.text,
          'Profession': profession.text,
          'Age': age.text,
          'About': intro.text,
          'Cv': cv.text,
          'Image': image,
          'AboutVoice': audio,
        };
        final resultRegister = await authUsecase.register(JobApplicationParams.fromJson(userData));
        resultRegister.fold(
          (failure) {
            loginState.value = LoginState.failure;
            SmartDialog.show(
              builder:
                  (context) => WidgetDilog(
                    isError: true,
                    title: AppText(context).warning,
                    message: failure.message,
                    cancelText: AppText(context).back,
                    onCancel: () => SmartDialog.dismiss(),
                  ),
            );
          },
          (sucess) {
            loginState.value = LoginState.failure;
            _clear();
            SmartDialog.show(
              builder:
                  (context) => WidgetDilog(
                    title: AppText(context).successfully,
                    message: AppText(context).youraccountiscurrentlyunderreviewWewillnotifyyouonceithabeenapprovedThankyoufoyourpatience,
                    cancelText: AppText(context).back,
                    onCancel: () => SmartDialog.dismiss(),
                  ),
            );
          },
        );
      } catch (e) {
        log('Server Error In Register Section : $e');
      }
    }
  }

  void modifyMobileNumber(String phone, String code) {
    mobile.text = phone;
    digitCode.text = code;
    notifyListeners();
  }

  // Switch between team login screens
  void switchTeam(String team) {
    if (selectedTeam != team) {
      selectedTeam = team;
      notifyListeners();
    }
  }

  _clear() {
    name.clear();
    email.clear();
    mobile.clear();
    address.clear();
    profession.clear();
    age.clear();
    intro.clear();
    cv.clear();
    image = null;
    audio = null;
    imagePath = null;
    filePath = null;
    audioRecord = {'path': '', 'duration': 0, 'stop': false};
    notifyListeners();
  }

  // Helper method to get role name for display
  String _getRoleName(BuildContext context, int roleId) {
    switch (roleId) {
      case 26:
        return AppText(context).roleSuperUser;
      case 23:
        return AppText(context).roleIndividual;
      case 20:
        return AppText(context).roleTeamLeader;
      case 21:
        return AppText(context).roleTechnician;
      case 22:
        return AppText(context).roleSubTechnician;
      case 18:
        return AppText(context).roleAdmin;
      default:
        return AppText(context).roleUnknown(roleId);
    }
  }

  changeCV() {
    cv.clear();
    notifyListeners();
  }

  // OTP Function
  Future<void> sendOTP(String phone) async {
    if (otpKey.currentState!.validate()) {
      try {
        sendOTPState.value = SendState.loading;
        String? fcmToken = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.fcmtoken);
        
        // Normalize phone number - handle URL encoding and different formats
        String normalizedPhone = phone.trim();
        
        // Decode URL encoding if present (%2B becomes +)
        try {
          normalizedPhone = Uri.decodeComponent(normalizedPhone);
        } catch (e) {
          // If decoding fails, use as-is
        }
        
        // Handle case where + was converted to space in URL query parameters
        if (normalizedPhone.startsWith(' ') && normalizedPhone.length > 1) {
          normalizedPhone = '+${normalizedPhone.substring(1).trim()}';
        }
        
        // Remove spaces and dashes (but keep +)
        normalizedPhone = normalizedPhone.replaceAll(' ', '').replaceAll('-', '').trim();
        
        // Handle different phone number formats
        // If it starts with 00, replace with +
        if (normalizedPhone.startsWith('00')) {
          normalizedPhone = '+${normalizedPhone.substring(2)}';
        }
        // If it doesn't start with + and has enough digits, it might be missing the +
        else if (!normalizedPhone.startsWith('+')) {
          // Check if it looks like a valid phone number (at least 10 digits)
          if (normalizedPhone.length >= 10 && RegExp(r'^\d+$').hasMatch(normalizedPhone)) {
            // This shouldn't happen if phone was properly validated, but handle it gracefully
            // Don't add + automatically as we don't know the country code
            sendOTPState.value = SendState.failure;
            return SmartDialog.show(
              builder:
                  (context) => WidgetDilog(
                    isError: true,
                    title: AppText(context).warning,
                    message: 'Please enter phone number with country code',
                    cancelText: AppText(context).back,
                    onCancel: () => SmartDialog.dismiss(),
                  ),
            );
          } else {
            sendOTPState.value = SendState.failure;
            return SmartDialog.show(
              builder:
                  (context) => WidgetDilog(
                    isError: true,
                    title: AppText(context).warning,
                    message: 'Invalid phone number format',
                    cancelText: AppText(context).back,
                    onCancel: () => SmartDialog.dismiss(),
                  ),
            );
          }
        }
        
        final sendOtpResponse = await authUsecase.sendOtp(mobile: normalizedPhone, otp: otp.text, fcm: fcmToken ?? '', team: selectedTeam);
        sendOtpResponse.fold(
          (l) {
            sendOTPState.value = SendState.failure;
            
            // Provide more specific error messages based on error type
            String errorMessage = l.message;
            if (l.message.toLowerCase().contains('expired')) {
              errorMessage = 'OTP has expired. Please request a new OTP';
            } else if (l.message.toLowerCase().contains('locked') || 
                       l.message.toLowerCase().contains('lockout')) {
              errorMessage = 'Account temporarily locked. Please try again later';
            } else if (l.message.toLowerCase().contains('attempt')) {
              // Show remaining attempts warning
              errorMessage = l.message; // Already contains attempt count
            }
            
            return SmartDialog.show(
              builder:
                  (context) => WidgetDilog(
                    isError: true,
                    title: AppText(context).warning,
                    message: errorMessage,
                    cancelText: AppText(context).back,
                    onCancel: () => SmartDialog.dismiss(),
                  ),
            );
          },
          (r) async {
            // Validate user data exists
            if (r.data?.user == null) {
              sendOTPState.value = SendState.failure;
              return SmartDialog.show(
                builder:
                    (context) => WidgetDilog(
                      isError: true,
                      title: AppText(context).warning,
                      message: AppText(context).userDataNotFoundAccessDenied,
                      cancelText: AppText(context).back,
                      onCancel: () => SmartDialog.dismiss(),
                    ),
              );
            }
            
            // Check user role before allowing login
            // Only allow TECHNICIAN (21) and SUB TECHNICIAN (22)
            final userRoleId = r.data?.user?.userRoleId;
            
            // Handle null role ID
            if (userRoleId == null) {
              sendOTPState.value = SendState.failure;
              return SmartDialog.show(
                builder:
                    (context) => WidgetDilog(
                      isError: true,
                      title: AppText(context).warning,
                      message: AppText(context).userRoleNotFoundAccessDenied,
                      cancelText: AppText(context).back,
                      onCancel: () => SmartDialog.dismiss(),
                    ),
              );
            }
            
            // Validate role ID is a valid positive integer
            if (userRoleId <= 0) {
              sendOTPState.value = SendState.failure;
              return SmartDialog.show(
                builder:
                    (context) => WidgetDilog(
                      isError: true,
                      title: AppText(context).warning,
                      message: AppText(context).invalidUserRoleIdAccessDenied,
                      cancelText: AppText(context).back,
                      onCancel: () => SmartDialog.dismiss(),
                    ),
              );
            }
            
            // Check if user has allowed role (21 = TECHNICIAN, 22 = SUB TECHNICIAN)
            if (userRoleId != 21 && userRoleId != 22) {
              sendOTPState.value = SendState.failure;
              return SmartDialog.show(
                builder:
                    (context) {
                      String roleName = _getRoleName(context, userRoleId);
                      String message = AppText(context).accessDeniedTechniciansOnlyWithRole(roleName);
                      // Fallback if translation is empty
                      if (message.isEmpty) {
                        message = 'Access denied. This app is only available for Technicians. Your role: $roleName';
                      }
                      log('Access denied for role: $userRoleId ($roleName)');
                      return WidgetDilog(
                        isError: true,
                        title: AppText(context).warning,
                        message: message,
                        cancelText: AppText(context).back,
                        onCancel: () => SmartDialog.dismiss(),
                      );
                    },
              );
            }
            
            // User has authorized role - proceed with login
            final box = sl<Box>(instanceName: BoxKeys.appBox);
            final userBox = sl<Box<User>>();
            
            box.put(BoxKeys.enableAuth, true);
            box.put(BoxKeys.usertoken, r.data?.token);
            box.put(BoxKeys.userTeam, selectedTeam); // Store team selection
            
            // Token expiration and refresh token are now saved in the repository
            // If not saved there (e.g., for WeFix Team), set a default expiration
            final expiresAt = box.get('${BoxKeys.usertoken}_expiresAt');
            if (expiresAt == null) {
              // Use default expiration from environment variables
              final expiresInSeconds = AppLinks.tokenDefaultExpirationHours * 60 * 60;
              final tokenExpiresAt = DateTime.now().add(Duration(seconds: expiresInSeconds));
              box.put('${BoxKeys.usertoken}_expiresAt', tokenExpiresAt.toIso8601String());
            }
            
            userBox.put(BoxKeys.userData, r.data!.user!);
            sendOTPState.value = SendState.success;
            return GlobalContext.context.push(RouterKey.layout);
          },
        );
      } catch (e) {
        sendOTPState.value = SendState.failure;
        log('Server Error In Send OTP Section : $e');
        // Handle backend internal server errors (e.g., HTTP 500)
        String errorMessage = AppText(GlobalContext.context).systemErrorDuringAuthentication;
        if (e.toString().contains('500') || e.toString().toLowerCase().contains('internal server error')) {
          errorMessage = AppText(GlobalContext.context).backendServerError;
        } else if (e.toString().contains('network') || e.toString().contains('connection')) {
          errorMessage = AppText(GlobalContext.context).networkErrorCheckConnection;
        }
        SmartDialog.show(
          builder:
              (context) => WidgetDilog(
                isError: true,
                title: AppText(context).warning,
                message: errorMessage,
                cancelText: AppText(context).back,
                onCancel: () => SmartDialog.dismiss(),
              ),
        );
      }
    }
  }

  Future<void> resendOTP(String phone) async {
    try {
      SmartDialog.showLoading(
        msg: AppText(GlobalContext.context, isFunction: true).loading,
        maskColor: Colors.black.withOpacity(0.5),
        backDismiss: false,
        builder: (context) {
          return CircularProgressIndicator(
            valueColor: const AlwaysStoppedAnimation<Color>(AppColor.white),
            backgroundColor: AppColor.primaryColor.withOpacity(0.8),
          );
        },
      );
      
      // Normalize phone number - remove spaces and dashes
      String normalizedPhone = phone.replaceAll(' ', '').replaceAll('-', '').trim();
      
      // Validate that it has country code
      if (!normalizedPhone.startsWith('+')) {
        SmartDialog.dismiss();
        return SmartDialog.show(
          builder:
              (context) => WidgetDilog(
                isError: true,
                title: AppText(context).warning,
                message: 'Please enter phone number with country code',
                cancelText: AppText(context).back,
                onCancel: () => SmartDialog.dismiss(),
              ),
        );
      }
      
      final loginRequiest = await authUsecase.login(mobile: normalizedPhone);
      loginRequiest.fold(
        (l) {
          SmartDialog.dismiss();
          
          // Check if it's a rate limiting error
          String errorMessage = l.message;
          if (l.message.toLowerCase().contains('wait') || 
              l.message.toLowerCase().contains('rate') ||
              l.message.toLowerCase().contains('60 seconds')) {
            errorMessage = 'Please wait 60 seconds before requesting a new OTP';
          }
          
          return SmartDialog.show(
            builder:
                (context) => WidgetDilog(
                  isError: true,
                  title: AppText(context).warning,
                  message: errorMessage,
                  cancelText: AppText(context).back,
                  onCancel: () => SmartDialog.dismiss(),
                ),
          );
        },
        (r) {
          SmartDialog.dismiss();
          return SmartDialog.show(
            builder:
                (context) => WidgetDilog(
                  title: AppText(context).successfully,
                  message: AppText(context).verifycodehasbeenresentcheckyourinbox,
                  cancelText: AppText(context).back,
                  onCancel: () => SmartDialog.dismiss(),
                ),
          );
        },
      );
    } catch (e) {
      SmartDialog.dismiss();
      log('Server Error In Resend OTP Section : $e');
      SmartDialog.show(
        builder:
            (context) => WidgetDilog(
              isError: true,
              title: AppText(context).warning,
              message: 'Network error. Please try again',
              cancelText: AppText(context).back,
              onCancel: () => SmartDialog.dismiss(),
            ),
      );
    }
  }

  // Biometrics Functions
  Future<void> isBiometricAuthAvailable() async {
    final localAuth = LocalAuthentication();
    bool isAvailable = await localAuth.canCheckBiometrics;
    isSupport = isAvailable;
  }

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics = await authFingerPrint.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics = await authFingerPrint.getAvailableBiometrics();
      isFaceIdEnabled =
          availableBiometrics.contains(BiometricType.weak) ||
          availableBiometrics.contains(BiometricType.face) ||
          availableBiometrics.contains(BiometricType.fingerprint);
    }
  }

  Future<void> authenticate(BuildContext context) async {
    bool authenticated = false;
    try {
      SmartDialog.showLoading(
        msg: AppText(context, isFunction: true).loading,
        maskColor: Colors.black.withOpacity(0.5),
        backDismiss: false,
        builder: (context) {
          return CircularProgressIndicator(
            valueColor: const AlwaysStoppedAnimation<Color>(AppColor.white),
            backgroundColor: AppColor.primaryColor.withOpacity(0.8),
          );
        },
      );
      authenticated = await LocalAuthentication().authenticate(
        localizedReason: "Scan yore finger to authentecate",
        options: const AuthenticationOptions(biometricOnly: true, stickyAuth: false),
      );

      if (authenticated) {
        sl<Box>(instanceName: BoxKeys.appBox).put(BoxKeys.enableAuth, true);
        SmartDialog.dismiss();
        context.go(RouterKey.layout);
      } else {
        SmartDialog.dismiss();
      }
    } on PlatformException catch (e) {
      SmartDialog.dismiss();
      log(e.toString());
    }
  }

  @override
  void dispose() {
    mobile.dispose();
    otp.dispose();
    super.dispose();
  }
}
