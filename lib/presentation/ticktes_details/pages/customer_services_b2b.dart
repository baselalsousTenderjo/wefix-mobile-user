import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/gap.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/providers/language_provider/l10n_provider.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/widget_cache_network_image.dart';
import '../controller/ticktes_details_controller.dart';

class CustomerServicesB2B extends StatelessWidget {
  const CustomerServicesB2B({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        String lang = languageProvider.lang ?? 'en';
        return Consumer<TicktesDetailsController>(
          builder: (context, controller, child) {
            final ticketsDetails = controller.ticketsDetails;
            final mainService = ticketsDetails?.mainService;
            final subService = ticketsDetails?.subService;
            final serviceTickets = ticketsDetails?.serviceTickets ?? [];
            
            // Check if services exist and have valid data
            final hasMainService = mainService != null && 
                ((mainService.name?.isNotEmpty ?? false) || (mainService.nameArabic?.isNotEmpty ?? false));
            final hasSubService = subService != null && 
                ((subService.name?.isNotEmpty ?? false) || (subService.nameArabic?.isNotEmpty ?? false));
            final hasServiceTickets = serviceTickets.isNotEmpty;
            
            // Don't render anything if no services available
            if (!hasMainService && !hasSubService && !hasServiceTickets) {
              return const SizedBox.shrink();
            }
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                Text('🛠 ${AppText(context).services}', style: AppTextStyle.style14B),
                8.gap,
                // Main Service - separate row with icon
                if (hasMainService) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Main Service Icon
                      if ((mainService.image ?? '').isNotEmpty) ...[
                        WidgetCachNetworkImage(
                          width: 32,
                          hieght: 32,
                          image: mainService.image ?? '',
                          radius: 4,
                        ),
                        8.gap,
                      ],
                      // Main Service Name
                      Expanded(
                        child: Text(
                          lang == 'ar' 
                              ? (mainService.nameArabic ?? mainService.name ?? '')
                              : (mainService.name ?? mainService.nameArabic ?? ''),
                          style: AppTextStyle.style12B,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  8.gap,
                ],
                // Sub Service - separate row with icon
                if (hasSubService) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Sub Service Icon
                      if ((subService.image ?? '').isNotEmpty) ...[
                        WidgetCachNetworkImage(
                          width: 32,
                          hieght: 32,
                          image: subService.image ?? '',
                          radius: 4,
                        ),
                        8.gap,
                      ],
                      // Sub Service Name
                      Expanded(
                        child: Text(
                          lang == 'ar' 
                              ? (subService.nameArabic ?? subService.name ?? '')
                              : (subService.name ?? subService.nameArabic ?? ''),
                          style: AppTextStyle.style12B,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  8.gap,
                ],
                // Service Tickets List - separate rows without counts
                if (hasServiceTickets) ...[
                  ...serviceTickets.expand((serviceTicket) => [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Service Ticket Icon
                        if ((serviceTicket.image ?? '').isNotEmpty) ...[
                          WidgetCachNetworkImage(
                            width: 50,
                            hieght: 50,
                            image: serviceTicket.image ?? '',
                            radius: 4,
                          ),
                          8.gap,
                        ],
                        // Service Ticket Name
                        Expanded(
                          child: Text(
                            lang == 'ar' 
                                ? (serviceTicket.nameAr ?? serviceTicket.name ?? '')
                                : (serviceTicket.name ?? serviceTicket.nameAr ?? ''),
                            style: AppTextStyle.style10B,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (serviceTicket != serviceTickets.last) 8.gap,
                  ]),
                ],
                2.gap,
              ],
            );
          },
        );
      },
    );
  }
}
