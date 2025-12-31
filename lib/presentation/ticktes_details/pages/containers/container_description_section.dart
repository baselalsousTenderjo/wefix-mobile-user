import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_loading.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';

class ContainnerDescriptionSection extends StatelessWidget {
  const ContainnerDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder:
          (context, controller, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: controller.ticketStatue,
                builder:
                    (context, value, child) =>
                        value == TicketStatus.loading
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('📝 ${AppText(context).issueDescription}', style: AppTextStyle.style14B),
                                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                                const WidgetLoading(width: double.infinity),
                                const WidgetLoading(width: double.infinity, top: 5),
                                const WidgetLoading(width: double.infinity, top: 5),
                                WidgetLoading(width: MediaQuery.of(context).size.width * .5, top: 5),
                              ],
                            )
                            : (controller.ticketsDetails?.description == null)
                            ? const SizedBox.shrink()
                            : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('📝 ${AppText(context).issueDescription}', style: AppTextStyle.style14B),
                                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                                Text(controller.ticketsDetails?.description ?? '', style: AppTextStyle.style14.copyWith(height: 1.5, color: AppColor.black)),
                              ],
                            ),
              ),
              20.gap,
            ],
          ),
    );
  }
}
