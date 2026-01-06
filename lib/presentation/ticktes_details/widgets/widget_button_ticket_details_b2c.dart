import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/app_text.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/button/app_button.dart';
import '../controller/ticktes_details_controller.dart';
import '../domain/ticket_enum.dart';

/// B2C Ticket Details Button - Shows start button with direct startRecording (original implementation)
class WidgetButtonTicketDetailsB2C extends StatelessWidget {
  const WidgetButtonTicketDetailsB2C({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder:
          (context, controller, child) => ValueListenableBuilder(
            valueListenable: controller.ticketStatue,
            builder: (context, value, child) {
              final ticketStatus = controller.ticketsDetails?.status?.toLowerCase();
              final isLoading = value == TicketStatus.loading;
              final isCanceled = ticketStatus == TicketDetailsStatus.cancelled.name;
              final isCompleted = ticketStatus == TicketDetailsStatus.completed.name;
              final isSuccess = value == TicketStatus.success;
              final isInProgress = ticketStatus == TicketDetailsStatus.inprogress.name;
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
                      child: Row(children: [Expanded(child: AppButton.text(text: AppText(context).viewReport, onPressed: () => controller.launchReport()))]),
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
                              : Row(
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: controller.startTicketStatue,
                                    builder:
                                        (context, status, child) => Expanded(
                                          child: AppButton.text(
                                            text: AppText(context).start,
                                            loading: status == StartTicketStatus.loading,
                                            onPressed: () => controller.startRecording(controller.ticketsDetails?.id.toString() ?? '0'),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
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
