import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';

import '../../../../core/constant/app_image.dart';
import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/services/hive_services/box_kes.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/model/user_model.dart';
import '../../controller/home_controller.dart';

class ContainerWelcomeUser extends StatelessWidget {
  const ContainerWelcomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final lang = languageProvider.lang ?? 'en';
        final isRTL = lang == 'ar';
        
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.iconEditProfile),
                  5.gap,
                  Text(AppText(context).welcome, textAlign: isRTL ? TextAlign.right : TextAlign.left, style: AppTextStyle.style12),
                  3.gap,
                  // Listen to both user data and language changes
                  ValueListenableBuilder(
                    valueListenable: sl<Box<User>>().listenable(),
                    builder: (context, value, child) {
                      return Consumer<LanguageProvider>(
                        builder: (context, languageProvider, child) {
                          return Consumer<HomeController>(
                            builder: (context, homeController, child) {
                              User? user = value.get(BoxKeys.userData);
                              final lang = languageProvider.lang ?? 'en';
                              
                              // Get name from home data if available, otherwise from user data
                              String displayName = '';
                              
                              if (homeController.currentHomeData?.technician != null) {
                                // Use technician data from home
                                if (lang == 'ar') {
                                  displayName = homeController.currentHomeData!.technician!.name ?? '';
                                } else {
                                  displayName = homeController.currentHomeData!.technician!.nameEnglish ?? '';
                                }
                              }
                              
                              // Fallback to user data if technician data is not available
                              if (displayName.isEmpty && user != null) {
                                if (lang == 'ar') {
                                  displayName = user.fullName ?? user.name ?? '';
                                } else {
                                  displayName = user.fullNameEnglish ?? user.name ?? '';
                                }
                              }
                              
                              final isRTLInner = lang == 'ar';
                              return Text(
                                displayName,
                                maxLines: 2,
                                textAlign: isRTLInner ? TextAlign.right : TextAlign.left,
                                style: AppTextStyle.style12B,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              5.gap,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.iconDate),
                  5.gap,
                  Text(DateFormat("MMM, d yyyy").format(DateTime.now()), style: AppTextStyle.style12B.copyWith(color: AppColor.primaryColor)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
