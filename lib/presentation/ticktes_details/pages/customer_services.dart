import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/gap.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/providers/language_provider/l10n_provider.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/widget_cache_network_image.dart';
import '../controller/ticktes_details_controller.dart';

class CustomerServices extends StatelessWidget {
  const CustomerServices({super.key});

  @override
  Widget build(BuildContext context) {
    String lang = context.read<LanguageProvider>().lang ?? 'en';
    return Consumer<TicktesDetailsController>(
      builder:
          (context, controller, child) {
            final mainService = controller.ticketsDetails?.mainService;
            final subService = controller.ticketsDetails?.subService;
            final hasMainService = mainService != null;
            final hasSubService = subService != null;
            final serviceTickets = controller.ticketsDetails?.serviceTickets ?? [];
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                Text('🛠 ${AppText(context).services}', style: AppTextStyle.style14B),
                8.gap,
                // Main Service with Icon
                if (hasMainService) ...[
                  Row(
                    children: [
                      // Main Service Icon
                      if ((mainService.image ?? '').isNotEmpty) ...[
                        WidgetCachNetworkImage(
                          width: 24,
                          hieght: 24,
                          image: mainService.image ?? '',
                          radius: 4,
                        ),
                        8.gap,
                      ],
                      // Main Service Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang == 'ar' ? (mainService.nameArabic ?? mainService.name ?? '') : (mainService.name ?? ''),
                              style: AppTextStyle.style12B,
                            ),
                            Text(
                              'Main Service',
                              style: AppTextStyle.style10.copyWith(color: AppColor.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.gap,
                ],
                // Sub Service with Icon
                if (hasSubService) ...[
                  Row(
                    children: [
                      // Sub Service Icon
                      if ((subService.image ?? '').isNotEmpty) ...[
                        WidgetCachNetworkImage(
                          width: 24,
                          hieght: 24,
                          image: subService.image ?? '',
                          radius: 4,
                        ),
                        8.gap,
                      ],
                      // Sub Service Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang == 'ar' ? (subService.nameArabic ?? subService.name ?? '') : (subService.name ?? ''),
                              style: AppTextStyle.style12B,
                            ),
                            Text(
                              'Sub Service',
                              style: AppTextStyle.style10.copyWith(color: AppColor.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.gap,
                ],
                // Service Tickets List (if any)
                if (serviceTickets.isNotEmpty) ...[
                  ListView.separated(
                    itemCount: serviceTickets.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => 8.gap,
                    itemBuilder:
                        (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}- ${lang == 'ar' ? (serviceTickets[index].nameAr ?? '') : serviceTickets[index].name ?? ''}',
                              style: AppTextStyle.style12B,
                            ),
                            Text(
                              '${AppText(context).quantity}: X${serviceTickets[index].quantity ?? '0'}',
                              style: AppTextStyle.style12,
                            ),
                          ],
                        ),
                  ),
                ],
                10.gap,
              ],
            );
          },
    );
  }
}
