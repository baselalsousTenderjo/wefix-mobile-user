import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/app_text.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/button/app_button.dart';
import '../controller/ticktes_details_controller.dart';
import '../domain/ticket_enum.dart';

/// B2B Ticket Details Button - Shows start button with attachment screen flow
class WidgetButtonTicketDetailsB2B extends StatelessWidget {
  const WidgetButtonTicketDetailsB2B({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder:
          (context, controller, child) => ValueListenableBuilder(
            valueListenable: controller.ticketStatue,
            builder: (context, value, child) {
              final rawStatus = controller.ticketsDetails?.status?.toLowerCase() ?? '';
              final ticketStatus = rawStatus.replaceAll(' ', '');
              final isLoading = value == TicketStatus.loading;
              final isCanceled = ticketStatus == TicketDetailsStatus.cancelled.name;
              final isCompleted = ticketStatus == TicketDetailsStatus.completed.name || ticketStatus == 'ended';
              final isSuccess = value == TicketStatus.success;
              final isInProgress = ticketStatus == TicketDetailsStatus.inprogress.name || ticketStatus == 'inprogress';
              final isPending = ticketStatus == TicketDetailsStatus.pending.name;
              final isRecording = controller.recording == true;

              if (isLoading) {
                return const SizedBox.shrink();
              }

              if (isSuccess) {
                if (isCanceled) {
                  return const SizedBox.shrink();
                } else if (isCompleted) {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColor.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${AppText(context).status}: ',
                              style: AppTextStyle.style14B,
                            ),
                            Text(
                              controller.ticketsDetails?.status ?? '',
                              style: AppTextStyle.style14.copyWith(color: AppColor.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child:
                          isRecording && isInProgress
                              ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                spacing: 15,
                                children: [
                                  if (controller.duration.value != 0)
                                    ValueListenableBuilder(
                                      valueListenable: controller.duration,
                                      builder: (context, duration, child) {
                                        Duration durationObject = Duration(seconds: duration);
                                        String formattedDuration = '${durationObject.inMinutes}:${(durationObject.inSeconds % 60).toString().padLeft(2, '0')}';
                                        return SafeArea(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                spacing: 10,
                                                children: [
                                                  Icon(Icons.timer, color: AppColor.primaryColor),
                                                  Text(AppText(context).theticketstartedat, style: AppTextStyle.style14B),
                                                ],
                                              ),
                                              Text(formattedDuration, style: AppTextStyle.style14B),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  Row(
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: controller.completeTicketStatue,
                                        builder:
                                            (context, status, child) => Expanded(
                                              child: AppButton.text(
                                                text: AppText(context).complete,
                                                loading: status == CompleteTicketStatus.loading,
                                                onPressed: () => controller.bottomSheetCompleteDetails(),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                              : isPending
                                  ? Row(
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable: controller.startTicketStatue,
                                          builder:
                                              (context, status, child) => Expanded(
                                                child: AppButton.text(
                                                  text: AppText(context).start,
                                                  loading: status == StartTicketStatus.loading,
                                                  onPressed: () => controller.showStartTicketAttachmentScreen(context, controller.ticketsDetails?.id.toString() ?? '0'),
                                                ),
                                              ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                    ),
                  );
                }
              }

              return const SizedBox.shrink();
            },
          ),
    );
  }
}
