import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/app_image.dart';
import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_cache_network_image.dart';
import '../../../../core/widget/widget_loading.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';

class ContainerCustomerSection extends StatelessWidget {
  const ContainerCustomerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder:
          (context, controller, child) => ValueListenableBuilder(
            valueListenable: controller.ticketStatue,
            builder: (context, value, child) {
              final creator = controller.ticketsDetails?.creator;
              
              // Hide section if no creator and not loading
              if (value != TicketStatus.loading && creator == null) {
                return const SizedBox.shrink();
              }
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey.withOpacity(.4), thickness: 1, height: 20),
                  Text('👤 ${AppText(context).createdBy}', style: AppTextStyle.style14B),
                  10.gap,
                  if (value == TicketStatus.loading) ...[
                    Row(
                      children: [
                        const WidgetLoading(width: 50, height: 50, radius: 100),
                        10.gap,
                        const WidgetLoading(width: 150),
                      ],
                    ),
                  ] else if (creator != null) ...[
                    Row(
                      children: [
                        WidgetCachNetworkImage(
                          width: 50, 
                          hieght: 50, 
                          image: creator.image ?? '', 
                          radius: 1000
                        ),
                        10.gap,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatCreatorName(context, creator),
                                overflow: TextOverflow.ellipsis, 
                                style: AppTextStyle.style10B
                              ),
                              if (creator.mobileNumber != null || creator.countryCode != null) ...[
                                5.gap,
                                Text(
                                  _formatPhoneNumber(creator.countryCode, creator.mobileNumber),
                                  style: AppTextStyle.style11.copyWith(color: Colors.grey.shade600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        // Phone icon to call creator
                        InkWell(
                          onTap: () {
                            if (creator.mobileNumber != null || creator.countryCode != null) {
                              context.read<TicktesDetailsController>().launchCall();
                            }
                          },
                          child: SvgPicture.asset(Assets.iconCall),
                        ),
                        10.gap,
                      ],
                    ),
                  ] else ...[
                    // No creator information available - hide section if no creator
                    const SizedBox.shrink(),
                  ],
                  20.gap,
                ],
              );
            },
          ),
    );
  }
  
  String _formatPhoneNumber(String? countryCode, String? mobileNumber) {
    // \u200E is the Left-to-Right Mark (LRM) to prevent RTL reversal of phone numbers
    if (countryCode != null && mobileNumber != null) {
      return '\u200E$countryCode $mobileNumber';
    } else if (mobileNumber != null) {
      return '\u200E$mobileNumber';
    } else if (countryCode != null) {
      return '\u200E$countryCode';
    }
    return '';
  }

  String _formatCreatorName(BuildContext context, dynamic creator) {
    if (creator == null) return '';
    
    final name = creator.name?.toString() ?? ''; // Arabic name from backend
    final nameEnglish = creator.nameEnglish?.toString() ?? ''; // English name from backend
    
    // Get current language from provider
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final currentLang = languageProvider.lang ?? 'en';
    
    // If both Arabic and English names are available, show both
    if (name.isNotEmpty && nameEnglish.isNotEmpty) {
      return currentLang == "ar" 
        ? '$name ($nameEnglish)'
        : '$nameEnglish ($name)';
    }
    
    // If only one language is available, use it
    if (name.isNotEmpty) {
      return name;
    }
    
    if (nameEnglish.isNotEmpty) {
      return nameEnglish;
    }
    
    return '';
  }
}
