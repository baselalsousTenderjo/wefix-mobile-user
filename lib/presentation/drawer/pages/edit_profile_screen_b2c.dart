import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/gap.dart';
import '../../../core/mixin/validation_mixin.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/services/hive_services/box_kes.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/button/app_button.dart';
import '../../../core/widget/language_button.dart';
import '../../../core/widget/widget_phone_field.dart';
import '../../../core/widget/widget_text_field.dart';
import '../../../injection_container.dart';
import '../../auth/domain/model/user_model.dart';
import '../controller/edit_profile/edit_profile_controller.dart';
import '../widgets/widget_edit_image_profile.dart';

/// B2C Edit Profile Screen - Shows user info without company details
class EditProfileScreenB2C extends StatelessWidget with FormValidationMixin {
  EditProfileScreenB2C({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<EditProfileController>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppText(context).profile, style: AppTextStyle.style16B),
          actions: const [LanguageButton()],
          centerTitle: true,
        ),
        body: Consumer<EditProfileController>(
          builder: (context, controller, child) {
            // Show loading state while fetching profile
            if (controller.profileStatus.value == ProfileStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            // Get user data - try controller first, then fallback to Hive
            User? user = controller.currentProfile;
            if (user == null) {
              user = sl<Box<User>>().get(BoxKeys.userData);
            }

            if (user == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppText(context).loading,
                      style: AppTextStyle.style14,
                    ),
                    20.gap,
                    AppButton.text(
                      text: AppText(context).continues,
                      onPressed: () => controller.loadProfile(),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Form(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.primaryColor.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User image and name - centered
                      10.gap,
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: AppColor.grey),
                              ),
                              child: WidhetEditImageProfile(imageUrl: user.image ?? user.profileImage ?? ''),
                            ),
                            10.gap,
                            // User name
                            Text(
                              user.name ?? user.fullName ?? 'User',
                              style: AppTextStyle.style14B.copyWith(color: AppColor.primaryColor),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Display user ID and type
                      if (user.id != null) ...[
                        10.gap,
                        Center(
                          child: Text('#${user.id}', style: AppTextStyle.style12.copyWith(color: AppColor.grey)),
                        ),
                      ],
                      5.gap,
                      Center(
                        child: Text(
                          AppText(context).weFixTeam,
                          style: AppTextStyle.style12B.copyWith(color: AppColor.primaryColor),
                        ),
                      ),
                      5.gap,
                      // Full Name - read-only
                      Text(AppText(context).fullNameArabic, style: AppTextStyle.style14B),
                      5.gap,
                      WidgetTextField(
                        AppText(context).enterYourName,
                        controller: TextEditingController(text: user.name ?? user.fullName ?? ''),
                        readOnly: true,
                      ),
                      5.gap,
                      // Email - read-only
                      Text(AppText(context).email, style: AppTextStyle.style14B),
                      5.gap,
                      WidgetTextField(
                        'example@example.com',
                        controller: TextEditingController(text: user.email ?? ''),
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      5.gap,
                      // Mobile - read-only
                      Text(AppText(context).mobile, style: AppTextStyle.style14B),
                      5.gap,
                      WidgetPhoneField(
                        phoneController: TextEditingController(
                          text: _getMobileNumber(user),
                        ),
                        code: _getCountryCodeFromUser(user),
                      ),
                      // Additional B2C fields from backend-tjms (ServiceProvider model)
                      // Address field
                      if (user.address != null && user.address!.isNotEmpty) ...[
                        5.gap,
                        Text('Address', style: AppTextStyle.style14B),
                        5.gap,
                        WidgetTextField(
                          'Address',
                          controller: TextEditingController(text: user.address ?? ''),
                          readOnly: true,
                        ),
                      ],
                      // Age field
                      if (user.age != null && user.age!.isNotEmpty) ...[
                        5.gap,
                        Text('Age', style: AppTextStyle.style14B),
                        5.gap,
                        WidgetTextField(
                          'Age',
                          controller: TextEditingController(text: user.age ?? ''),
                          readOnly: true,
                        ),
                      ],
                      // Profession field
                      if (user.profession != null && user.profession!.isNotEmpty) ...[
                        5.gap,
                        Text('Profession', style: AppTextStyle.style14B),
                        5.gap,
                        WidgetTextField(
                          'Profession',
                          controller: TextEditingController(text: user.profession ?? ''),
                          readOnly: true,
                        ),
                      ],
                      // About Me (Introduce) field - mapped from backend-tjms AboutMe
                      if (user.introduce != null && user.introduce!.isNotEmpty) ...[
                        5.gap,
                        Text('About Me', style: AppTextStyle.style14B),
                        5.gap,
                        WidgetTextField(
                          'About Me',
                          controller: TextEditingController(text: user.introduce ?? ''),
                          readOnly: true,
                          maxLines: 3,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  String _getMobileNumber(User? user) {
    if (user == null) return '';
    
    if (user.mobileNumber != null && user.mobileNumber!.isNotEmpty) {
      return user.mobileNumber!;
    }
    
    if (user.mobile != null && user.mobile!.isNotEmpty) {
      String mobile = user.mobile!;
      
      // Remove country code if present
      final commonCodes = ['+962', '+971', '+966', '+974', '+965', '+968', '+961', '+963', '+20', '+212', '+213', '+216', '+218', '+249', '+967'];
      for (final code in commonCodes) {
        if (mobile.startsWith(code)) {
          mobile = mobile.substring(code.length).trim();
          break;
        }
      }
      
      return mobile;
    }
    
    return '';
  }
  
  String? _getCountryCodeFromUser(User? user) {
    if (user?.mobile != null && user!.mobile!.isNotEmpty) {
      // Extract country code from mobile number
      final mobile = user.mobile!;
      final countryCodeMap = {
        '+962': 'JO', '+971': 'AE', '+964': 'IQ', '+966': 'SA', '+974': 'QA',
        '+970': 'PS', '+965': 'KW', '+968': 'OM', '+961': 'LB', '+963': 'SY',
        '+20': 'EG', '+212': 'MA', '+213': 'DZ', '+216': 'TN', '+218': 'LY',
        '+249': 'SD', '+967': 'YE', '+1': 'US', '+44': 'GB', '+33': 'FR',
        '+49': 'DE', '+39': 'IT', '+34': 'ES', '+7': 'RU', '+86': 'CN',
        '+91': 'IN', '+81': 'JP', '+82': 'KR', '+61': 'AU', '+27': 'ZA',
        '+90': 'TR', '+30': 'GR',
      };
      
      for (final entry in countryCodeMap.entries) {
        if (mobile.startsWith(entry.key)) {
          return entry.value;
        }
      }
    }
    
    return 'JO'; // Default to Jordan
  }
}
