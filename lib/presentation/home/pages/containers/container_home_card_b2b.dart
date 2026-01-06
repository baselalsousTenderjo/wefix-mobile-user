import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/app_image.dart';
import '../../../../core/constant/app_links.dart';
import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/services/hive_services/box_kes.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_cache_network_image.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/model/user_model.dart';
import '../../controller/home_controller.dart';

/// B2B Home Card - Shows company logo, technician image, and company name
/// This version is for B2B Team (backend-tmms)
class ContainerHomeCardB2B extends StatelessWidget {
  const ContainerHomeCardB2B({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sl<Box<User>>().listenable(),
      builder: (context, value, child) {
        User? user = value.get(BoxKeys.userData);
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            final lang = languageProvider.lang ?? 'en';
            final isRTL = lang == 'ar';
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColor.grey.withOpacity(0.4), width: 1)),
              child: Stack(
                alignment: isRTL ? Alignment.centerLeft : Alignment.centerRight,
                children: [
                  Transform.rotate(angle: isRTL ? math.pi : 2 * math.pi, child: SvgPicture.asset(Assets.iconHomeCard)),
                  // Company logo positioned in the orange space
                  // For RTL (Arabic): position on left, for LTR (English): position on right
                  Positioned(
                    right: isRTL ? null : 10,
                    left: isRTL ? 10 : null,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsetsDirectional.only(end: 20, start: 20),
                      child: Consumer<HomeController>(
                        builder: (context, controller, child) {
                          // Get company logo from home data (backend-tmms)
                          final companyLogo = controller.currentHomeData?.technician?.company?.logo;

                          // Construct full URL if logo path is relative
                          String? logoUrl;
                          if (companyLogo != null && companyLogo.isNotEmpty) {
                            if (companyLogo.startsWith('http://') || companyLogo.startsWith('https://')) {
                              // Already a full URL
                              logoUrl = companyLogo;
                            } else {
                              // Relative path, prepend base URL
                              // Remove /api/v1 from base URL if present, then append logo path
                              String baseUrl = AppLinks.getServerForTeam();
                              if (baseUrl.endsWith('/api/v1')) {
                                baseUrl = baseUrl.replaceAll('/api/v1', '');
                              } else if (baseUrl.endsWith('/api/v1/')) {
                                baseUrl = baseUrl.replaceAll('/api/v1/', '');
                              }
                              // Ensure baseUrl doesn't end with / and logoPath starts with /
                              baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
                              logoUrl = '$baseUrl$companyLogo';
                            }
                          }

                          return Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: logoUrl == null || logoUrl.isEmpty ? Colors.grey[200] : Colors.transparent),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child:
                                  logoUrl == null || logoUrl.isEmpty
                                      ? Icon(Icons.business, size: 50, color: Colors.grey[400])
                                      : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: WidgetCachNetworkImage(width: 84, hieght: 84, radius: 0, boxFit: BoxFit.contain, image: logoUrl),
                                      ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Use Directionality based on language for proper RTL/LTR support
                  Positioned(
                    left: isRTL ? null : 40,
                    right: isRTL ? 40 : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Center(
                        child: Consumer<HomeController>(
                          builder: (context, controller, child) {
                            final technician = controller.currentHomeData?.technician;

                            // Get technician image
                            final technicianImage = technician?.image;
                            final imagePath = technicianImage ?? user?.profileImage ?? user?.image;

                            // Construct full URL if image path is relative
                            String? imageUrl;
                            if (imagePath != null && imagePath.isNotEmpty) {
                              if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
                                // Already a full URL
                                imageUrl = imagePath;
                              } else {
                                // Relative path, prepend base URL
                                String baseUrl = AppLinks.getServerForTeam();
                                if (baseUrl.endsWith('/api/v1')) {
                                  baseUrl = baseUrl.replaceAll('/api/v1', '');
                                } else if (baseUrl.endsWith('/api/v1/')) {
                                  baseUrl = baseUrl.replaceAll('/api/v1/', '');
                                }
                                baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
                                imageUrl = '$baseUrl$imagePath';
                              }
                            }

                            // Show name based on selected language
                            String technicianName;
                            if (lang == 'ar') {
                              // For Arabic: show Arabic name only
                              if (user?.fullName != null && user!.fullName!.isNotEmpty) {
                                technicianName = user.fullName!;
                              } else if (technician?.name != null && technician!.name!.isNotEmpty) {
                                technicianName = technician.name!;
                              } else {
                                technicianName = '';
                              }
                            } else {
                              // For English: show English name only
                              if (user?.fullNameEnglish != null && user!.fullNameEnglish!.isNotEmpty) {
                                technicianName = user.fullNameEnglish!;
                              } else if (technician?.nameEnglish != null && technician!.nameEnglish!.isNotEmpty) {
                                technicianName = technician.nameEnglish!;
                              } else {
                                technicianName = '';
                              }
                            }

                            // Get company name
                            final company = technician?.company;
                            final companyName = lang == 'ar' ? (company?.nameArabic ?? company?.name ?? '') : (company?.nameEnglish ?? company?.name ?? '');

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Technician image above name
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                                  child: ClipOval(
                                    child:
                                        imageUrl == null || imageUrl.isEmpty
                                            ? Image.asset(Assets.imageUser, fit: BoxFit.cover)
                                            : WidgetCachNetworkImage(radius: 1000, boxFit: BoxFit.cover, image: imageUrl),
                                  ),
                                ),
                                8.gap,
                                Text(technicianName, style: AppTextStyle.style18B, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                                if (technicianName.isEmpty) Text(AppText(context).loading, style: AppTextStyle.style14.copyWith(color: AppColor.grey), textAlign: TextAlign.center),
                                if (companyName.isNotEmpty) ...[
                                  5.gap,
                                  Text(
                                    companyName,
                                    style: AppTextStyle.style14.copyWith(color: AppColor.grey),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
