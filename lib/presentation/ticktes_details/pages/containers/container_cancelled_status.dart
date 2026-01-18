import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';

class ContainerCancelledStatus extends StatelessWidget {
  const ContainerCancelledStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder: (context, controller, child) {
        return ValueListenableBuilder(
          valueListenable: controller.ticketStatue,
          builder: (context, value, child) {
            if (value == TicketStatus.loading) {
              return const SizedBox.shrink();
            }

            // Check if ticket is cancelled
            final rawStatus = controller.ticketsDetails?.status?.toLowerCase() ?? '';
            final ticketStatus = rawStatus.replaceAll(' ', '');
            final isCanceled = ticketStatus == TicketDetailsStatus.cancelled.name;

            if (!isCanceled) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.gap,
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                Row(
                  children: [
                    Icon(Icons.cancel, size: 18, color: AppColor.red),
                    5.gap,
                    Text(
                      '${AppText(context).cancelled}',
                      style: AppTextStyle.style14B.copyWith(color: AppColor.red),
                    ),
                  ],
                ),
                10.gap,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColor.red.withOpacity(0.3)),
                  ),
                  child: Text(
                    AppText(context).thisrequestwascanceled,
                    style: AppTextStyle.style12.copyWith(
                      height: 1.5,
                      color: AppColor.red,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

