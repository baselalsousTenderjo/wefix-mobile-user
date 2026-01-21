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
import '../../../core/services/token_management/token_refresh.dart';
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
  final ValueNotifier<String> selectedTeam = ValueNotifier<String>('B2B Team'); // Default to B2B Team

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
        
        final loginRequiest = await authUsecase.login(mobile: normalizedMobile, team: selectedTeam.value);
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
                    } else if (errorMessage.toLowerCase().contains('inactive') ||
                               errorMessage.toLowerCase().contains('غير نشط')) {
                      final localized = AppText(context).accountInactiveMessage;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('wait') || 
                               errorMessage.toLowerCase().contains('rate') ||
                               errorMessage.toLowerCase().contains('seconds before')) {
                      // Extract seconds from message if available
                      final secondsMatch = RegExp(r'(\d+)\s*seconds?').firstMatch(errorMessage);
                      final seconds = secondsMatch?.group(1) ?? '60';
                      
                      // Use localized message with seconds
                      final lang = Localizations.localeOf(context).languageCode;
                      if (lang == 'ar') {
                        errorMessage = 'يرجى الانتظار $seconds ثانية قبل طلب رمز جديد';
                      } else {
                        errorMessage = 'Please wait $seconds seconds before requesting a new OTP';
                      }
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
                               errorMessage.toLowerCase().contains('403') ||
                               errorMessage.toLowerCase().contains('access denied')) {
                      // Check if it's the specific "service not available" message
                      if (errorMessage.toLowerCase().contains('service is not available') ||
                          errorMessage.toLowerCase().contains('الخدمة غير متاحة')) {
                        // Use localized message from languages.json
                        final localized = AppText(context).accessDeniedServiceNotAvailable;
                        errorMessage = localized.isNotEmpty ? localized : errorMessage;
                      } else if (errorMessage.isEmpty) {
                        // Fallback if message is empty
                        final localized = AppText(context).forbidden;
                        errorMessage = localized.isNotEmpty ? localized : 'Access denied';
                      }
                      // Otherwise, display the backend message as-is
                    } else if (errorMessage.toLowerCase().contains('not found') ||
                               errorMessage.toLowerCase().contains('404')) {
                      final localized = AppText(context).notFound;
                      errorMessage = localized.isNotEmpty ? localized : errorMessage;
                    } else if (errorMessage.toLowerCase().contains('connection error') ||
                               errorMessage.toLowerCase().contains('connection timeout') ||
                               errorMessage.toLowerCase().contains('receive timeout') ||
                               errorMessage.toLowerCase().contains('send timeout') ||
                               errorMessage.toLowerCase().contains('offline') ||
                               (errorMessage.toLowerCase().contains('endpoint') && errorMessage.toLowerCase().contains('offline')) ||
                               errorMessage.toLowerCase().contains('service unavailable')) {
                      // Handle any connection/offline errors - service is unavailable
                      final localized = AppText(context).serviceUnavailable;
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
            // Store team selection before navigating to OTP screen
            try {
              sl<Box>(instanceName: BoxKeys.appBox).put(BoxKeys.userTeam, selectedTeam.value);
            } catch (e) {
              log('Error storing team: $e');
            }
            
            // Pass normalized mobile to OTP screen
            String normalizedMobile = mobile.text.replaceAll(' ', '').replaceAll('-', '').trim();
            
            // Build URL with mobile and team - OTP auto-fill is disabled
            String otpUrl = '${RouterKey.login + RouterKey.otp}?mobile=${Uri.encodeComponent(normalizedMobile)}&team=${Uri.encodeComponent(selectedTeam.value)}';
            
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
                message: AppText(context).serviceUnavailable,
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
    if (selectedTeam.value != team) {
      selectedTeam.value = team;
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
        
        // Get team from storage if available, otherwise use current selectedTeam
        String teamToUse = selectedTeam.value;
        try {
          final storedTeam = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
          if (storedTeam != null) {
            teamToUse = storedTeam.toString();
          }
        } catch (e) {
          // Use selectedTeam if storage fails
          teamToUse = selectedTeam.value;
        }
        
        // If team is empty, default to B2B Team (since that's the default)
        if (teamToUse.isEmpty) {
          teamToUse = 'B2B Team';
        }
        
        // Validate OTP is not empty before sending
        final trimmedOTP = otp.text.trim();
        if (trimmedOTP.isEmpty || trimmedOTP.length < 4) {
          sendOTPState.value = SendState.failure;
          return SmartDialog.show(
            builder: (context) => WidgetDilog(
              isError: true,
              title: AppText(context).warning,
              message: AppText(context).otpRequired,
              cancelText: AppText(context).back,
              onCancel: () => SmartDialog.dismiss(),
            ),
          );
        }
        
        final sendOtpResponse = await authUsecase.sendOtp(mobile: normalizedPhone, otp: trimmedOTP, fcm: fcmToken ?? '', team: teamToUse);
        sendOtpResponse.fold(
          (l) {
            sendOTPState.value = SendState.failure;
            
            // Provide more specific error messages based on error type
            String errorMessage = l.message;
            if (l.message.toLowerCase().contains('inactive') ||
                l.message.toLowerCase().contains('غير نشط')) {
              final localized = AppText(GlobalContext.context).accountInactiveMessage;
              errorMessage = localized.isNotEmpty ? localized : l.message;
            } else if (l.message.toLowerCase().contains('expired')) {
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
            
            // Role check is now done at OTP request stage in backend-tmms
            // If we reach here, the user is allowed to login
            
            // User has authorized role - proceed with login
            final box = sl<Box>(instanceName: BoxKeys.appBox);
            final userBox = sl<Box<User>>();
            
            box.put(BoxKeys.enableAuth, true);
            
            // Save access token - ensure it's not null
            final accessToken = r.data?.token;
            if (accessToken != null && accessToken.toString().isNotEmpty) {
              box.put(BoxKeys.usertoken, accessToken);
              log('Access token saved successfully');
            } else {
              log('WARNING: Access token is null or empty!');
            }
            
            // Store team selection - critical for token refresh
            box.put(BoxKeys.userTeam, selectedTeam.value);
            log('Team saved: ${selectedTeam.value}');
            
            // Save refresh token if provided (only for B2B Team)
            if (r.data?.refreshToken != null && r.data!.refreshToken!.isNotEmpty) {
              box.put('${BoxKeys.usertoken}_refresh', r.data!.refreshToken);
              log('Refresh token saved successfully');
            } else {
              // WeFix Team doesn't provide refresh tokens - this is expected
              if (selectedTeam.value == 'WeFix Team') {
                log('WeFix Team login - No refresh token (expected, WeFix Team uses access token only)');
              } else {
                log('WARNING: Refresh token is null or empty for B2B Team!');
              }
            }
            
            // Token expiration - save for both B2B and WeFix Team
            // B2B Team: Saved in repository from token response
            // WeFix Team: Need to set default expiration (no refresh token, so expiration is critical)
            final expiresAt = box.get('${BoxKeys.usertoken}_expiresAt');
            if (expiresAt == null) {
              // Calculate expiration time based on expiresIn from response or use default
              int expiresInSeconds;
              if (r.data?.expiresIn != null) {
                // expiresIn can be int or String from backend
                expiresInSeconds = r.data!.expiresIn is int 
                    ? r.data!.expiresIn as int
                    : int.tryParse(r.data!.expiresIn.toString()) ?? (AppLinks.tokenDefaultExpirationHours * 60 * 60);
              } else {
                // Use default expiration from environment variables
                expiresInSeconds = AppLinks.tokenDefaultExpirationHours * 60 * 60;
              }
              final tokenExpiresAt = DateTime.now().add(Duration(seconds: expiresInSeconds));
              box.put('${BoxKeys.usertoken}_expiresAt', tokenExpiresAt.toIso8601String());
              log('Token expiration saved: ${tokenExpiresAt.toIso8601String()} (Team: ${selectedTeam.value})');
            } else {
              log('Token expiration already saved: $expiresAt');
            }
            
            // Save user data - ensure it's not null
            if (r.data?.user != null) {
              userBox.put(BoxKeys.userData, r.data!.user!);
              log('User data saved successfully - Name: ${r.data!.user!.fullName ?? r.data!.user!.name}, Team: ${selectedTeam.value}, Role: ${r.data!.user!.userRoleId}');
            } else {
              log('ERROR: User data is null! Cannot save user.');
            }
            
            // Verify all critical data is saved
            final savedToken = box.get(BoxKeys.usertoken);
            final savedRefreshToken = box.get('${BoxKeys.usertoken}_refresh');
            final savedTeam = box.get(BoxKeys.userTeam);
            final savedUser = userBox.get(BoxKeys.userData);
            
            log('Login verification - Token: ${savedToken != null}, RefreshToken: ${savedRefreshToken != null}, Team: $savedTeam, User: ${savedUser != null}');
            
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
      
      // Get team from storage if available, otherwise use current selectedTeam
      String? teamToUse = selectedTeam.value;
      try {
        final storedTeam = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
        if (storedTeam != null) {
          teamToUse = storedTeam.toString();
        }
      } catch (e) {
        // Use selectedTeam if storage fails
        teamToUse = selectedTeam.value;
      }
      
      final loginRequiest = await authUsecase.login(mobile: normalizedPhone, team: teamToUse);
      loginRequiest.fold(
        (l) {
          SmartDialog.dismiss();
          
          // Check if it's a rate limiting error - use localized message
          String errorMessage = l.message;
          if (l.message.toLowerCase().contains('wait') || 
              l.message.toLowerCase().contains('rate') ||
              l.message.toLowerCase().contains('60 seconds') ||
              l.message.toLowerCase().contains('seconds before')) {
            // Check if we have an Arabic message in the error response
            // Extract seconds from message if available
            final secondsMatch = RegExp(r'(\d+)\s*seconds?').firstMatch(l.message);
            final seconds = secondsMatch?.group(1) ?? '60';
            
            // Use localized message with seconds
            final lang = Localizations.localeOf(GlobalContext.context).languageCode;
            if (lang == 'ar') {
              errorMessage = 'يرجى الانتظار $seconds ثانية قبل طلب رمز جديد';
            } else {
              errorMessage = 'Please wait $seconds seconds before requesting a new OTP';
            }
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
              message: AppText(context).serviceUnavailable,
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
    User? user;
    
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
        // Load user data from storage
        final userBox = sl<Box<User>>();
        user = userBox.get(BoxKeys.userData);
        
        // Load tokens from storage (they should already be there from previous login)
        final box = sl<Box>(instanceName: BoxKeys.appBox);
        final token = box.get(BoxKeys.usertoken);
        final refreshToken = box.get('${BoxKeys.usertoken}_refresh');
        final tokenExpiresAt = box.get('${BoxKeys.usertoken}_expiresAt');
        final storedTeam = box.get(BoxKeys.userTeam);
        final currentTeam = selectedTeam.value;
        
        log('Biometric auth successful - User: ${user?.fullName ?? user?.name ?? "null"}, Stored Team: $storedTeam, Current Team: $currentTeam');
        log('Token exists: ${token != null}, RefreshToken exists: ${refreshToken != null}, ExpiresAt: $tokenExpiresAt');
        
        // CRITICAL: Validate that stored user's team matches currently selected team
        // Prevent cross-team fingerprint authentication
        if (storedTeam != null && storedTeam != currentTeam) {
          log('Team mismatch detected - Stored: $storedTeam, Current: $currentTeam');
          SmartDialog.dismiss();
          SmartDialog.show(
            builder: (context) => WidgetDilog(
              isError: true,
              title: AppText(context).warning,
              message: storedTeam == 'B2B Team'
                  ? 'This fingerprint is for B2B Team. Please select B2B Team to use fingerprint authentication.'
                  : 'This fingerprint is for WeFix Team. Please select WeFix Team to use fingerprint authentication.',
              cancelText: AppText(context).back,
              onCancel: () => SmartDialog.dismiss(),
            ),
          );
          return;
        }
        
        // If no stored team but user exists, this is an old session - require re-login
        if (storedTeam == null && user != null) {
          log('No team stored for existing user - requiring re-login');
          SmartDialog.dismiss();
          SmartDialog.show(
            builder: (context) => WidgetDilog(
              isError: true,
              title: AppText(context).warning,
              message: 'Session expired. Please login again.',
              cancelText: AppText(context).back,
              onCancel: () => SmartDialog.dismiss(),
            ),
          );
          return;
        }
        
        final userTeam = storedTeam ?? currentTeam;
        
        // Verify we have valid user data AND at least a token or refresh token
        // Strategy differs by team:
        // - B2B Team: Need refresh token OR access token
        // - WeFix Team: Need access token (no refresh token available)
        final bool hasValidAuth = user != null && (
          token != null || 
          (refreshToken != null && userTeam == 'B2B Team') ||
          (token != null && userTeam == 'WeFix Team')
        );
        
        if (hasValidAuth) {
          // B2B Team: If we have refresh token but no access token, try to refresh it first
          if (userTeam == 'B2B Team' && token == null && refreshToken != null) {
            log('B2B Team: Access token missing but refresh token exists - attempting refresh...');
            try {
              final refreshed = await refreshAccessToken();
              if (refreshed) {
                final newToken = box.get(BoxKeys.usertoken);
                log('B2B Team: Token refreshed successfully: ${newToken != null}');
              } else {
                log('B2B Team: Token refresh failed during biometric auth');
                SmartDialog.dismiss();
                SmartDialog.show(
                  builder: (context) => WidgetDilog(
                    isError: true,
                    title: AppText(context).warning,
                    message: AppText(context).pleaseLoginWithMobileNumber,
                    cancelText: AppText(context).back,
                    onCancel: () => SmartDialog.dismiss(),
                  ),
                );
                return;
              }
            } catch (e) {
              log('Error refreshing token during biometric auth: $e');
              SmartDialog.dismiss();
              SmartDialog.show(
                builder: (context) => WidgetDilog(
                  isError: true,
                  title: AppText(context).warning,
                  message: 'Authentication error. Please login again.',
                  cancelText: AppText(context).back,
                  onCancel: () => SmartDialog.dismiss(),
                ),
              );
              return;
            }
          } else if (userTeam == 'WeFix Team' && token == null) {
            // WeFix Team: No refresh token available, need access token
            log('WeFix Team: Access token missing - cannot authenticate with fingerprint');
            SmartDialog.dismiss();
            SmartDialog.show(
              builder: (context) => WidgetDilog(
                isError: true,
                title: AppText(context).warning,
                message: 'Authentication token expired. Please login again.',
                cancelText: AppText(context).back,
                onCancel: () => SmartDialog.dismiss(),
              ),
            );
            return;
          }
          
          // Mark as authenticated
          box.put(BoxKeys.enableAuth, true);
          
          // Ensure team is set and matches current selection
          if (userTeam != currentTeam) {
            box.put(BoxKeys.userTeam, currentTeam);
            log('Team updated to match current selection: $currentTeam');
          }
          
          SmartDialog.dismiss();
          context.go(RouterKey.layout);
        } else {
          SmartDialog.dismiss();
          String errorMessage = AppText(context).userDataNotFoundAccessDenied;
          if (user == null) {
            errorMessage = AppText(context).userDataNotFoundAccessDenied;
          } else if (token == null && refreshToken == null) {
            errorMessage = 'No authentication tokens found. Please login again.';
          }
          
          SmartDialog.show(
            builder: (context) => WidgetDilog(
              isError: true,
              title: AppText(context).warning,
              message: errorMessage,
              cancelText: AppText(context).back,
              onCancel: () => SmartDialog.dismiss(),
            ),
          );
        }
      } else {
        SmartDialog.dismiss();
      }
    } on PlatformException catch (e) {
      SmartDialog.dismiss();
      log('Biometric authentication error: $e');
      SmartDialog.show(
        builder: (context) => WidgetDilog(
          isError: true,
          title: AppText(context).warning,
          message: 'Biometric authentication failed. Please try again.',
          cancelText: AppText(context).back,
          onCancel: () => SmartDialog.dismiss(),
        ),
      );
    } catch (e) {
      SmartDialog.dismiss();
      log('Error during biometric authentication: $e');
    }
  }

  @override
  void dispose() {
    mobile.dispose();
    otp.dispose();
    selectedTeam.dispose();
    super.dispose();
  }
}
