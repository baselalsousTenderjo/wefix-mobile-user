import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_cache_network_image.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';

class ContainerTeamSection extends StatelessWidget {
  const ContainerTeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        String lang = languageProvider.lang ?? 'en';
        return Consumer<TicktesDetailsController>(
          builder: (context, controller, child) {
        return ValueListenableBuilder(
          valueListenable: controller.ticketStatue,
          builder: (context, value, child) {
            final ticketsDetails = controller.ticketsDetails;
            final teamLeader = ticketsDetails?.teamLeader;
            final technician = ticketsDetails?.technician;

            // Check if we have team data
            final hasTeamData = teamLeader != null || technician != null;

            if (value == TicketStatus.loading) {
              return const SizedBox.shrink();
            }

            // If no team data available, hide section
            if (!hasTeamData) {
              return const SizedBox.shrink();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                Text(
                  '👥 ${lang == "ar" ? "معلومات الفريق" : "Team Information"}',
                  style: AppTextStyle.style14B,
                ),
                10.gap,
                // Team Leader
                if (teamLeader != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${lang == "ar" ? "قائد الفريق" : "Team Leader"}:',
                            style: AppTextStyle.style10.copyWith(
                              color: AppColor.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              // Team Leader Image
                              if (teamLeader['profileImage'] != null && 
                                  teamLeader['profileImage'].toString().isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: ClipOval(
                                    child: WidgetCachNetworkImage(
                                      width: 40,
                                      hieght: 40,
                                      image: teamLeader['profileImage'].toString(),
                                      radius: 1000,
                                      boxFit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 10),
                              // Team Leader Name
                              Expanded(
                                child: Text(
                                  _getUserName(teamLeader, lang),
                                  style: AppTextStyle.style10.copyWith(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                // Technician
                if (technician != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${lang == "ar" ? "الفني" : "Technician"}:',
                            style: AppTextStyle.style10.copyWith(
                              color: AppColor.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              // Technician Image
                              if (technician['profileImage'] != null && 
                                  technician['profileImage'].toString().isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: ClipOval(
                                    child: WidgetCachNetworkImage(
                                      width: 40,
                                      hieght: 40,
                                      image: technician['profileImage'].toString(),
                                      radius: 1000,
                                      boxFit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 10),
                              // Technician Name
                              Expanded(
                                child: Text(
                                  _getUserName(technician, lang),
                                  style: AppTextStyle.style10.copyWith(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                20.gap,
              ],
            );
          },
        );
        },
      );
    },
    );
  }

  String _getUserName(dynamic user, String currentLang) {
    if (user == null) return '';
    
    final userMap = user is Map ? user : {};
    final name = (userMap['name']?.toString() ?? '').trim(); // Arabic name (fullName)
    final nameEnglish = (userMap['nameEnglish']?.toString() ?? '').trim(); // English name (fullNameEnglish)
    
    // Return the appropriate name based on current language
    if (currentLang == "ar") {
      // For Arabic, prefer name, fallback to nameEnglish
      return name.isNotEmpty ? name : nameEnglish;
    } else {
      // For English, prefer nameEnglish, fallback to name
      return nameEnglish.isNotEmpty ? nameEnglish : name;
    }
  }
}
