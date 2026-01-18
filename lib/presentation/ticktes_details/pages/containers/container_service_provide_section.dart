import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_loading.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';

class ContainerServiceProvideSection extends StatelessWidget {
  const ContainerServiceProvideSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder:
          (context, controller, child) => ValueListenableBuilder(
            valueListenable: controller.ticketStatue,
            builder:
                (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                    Text('🛠 ${AppText(context).serviceProviderActions}', style: AppTextStyle.style14B),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('🕑 ${AppText(context).estimatedFixTime}', style: AppTextStyle.style12B),
                        value == TicketStatus.loading
                            ? const WidgetLoading(width: 50)
                            : Expanded(
                              child: Text(
                                '${controller.ticketsDetails?.esitmatedTime ?? 0} ${AppText(context).hours}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.style10,
                              ),
                            ),
                      ],
                    ),

                    if (controller.ticketsDetails?.type != TicketDetailsType.preventive.name) ...[
                      5.gap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('🔩 ${AppText(context).partsRequired}', style: AppTextStyle.style12B),
                          value == TicketStatus.loading
                              ? const WidgetLoading(width: 50)
                              : Expanded(
                                child: Text(
                                  controller.ticketsDetails?.isWithMaterial.toString() == 'true' ? AppText(context).yes : AppText(context).no,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: AppTextStyle.style10,
                                ),
                              ),
                        ],
                      ),
                    ],
                    5.gap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('👩‍⚕️ ${AppText(context).female}', style: AppTextStyle.style12B),
                        value == TicketStatus.loading
                            ? const WidgetLoading(width: 50)
                            : Expanded(
                              child: Text(
                                controller.ticketsDetails?.isWithFemale.toString() == 'true' ? AppText(context).yes : AppText(context).no,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: AppTextStyle.style10,
                              ),
                            ),
                      ],
                    ),
                    20.gap,
                  ],
                ),
          ),
    );
  }
}
