import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/app_text.dart';
import '../../../../core/router/router_key.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';

class ContainerCompletionChecklist extends StatelessWidget {
  final String id;
  const ContainerCompletionChecklist({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('✅ ${AppText(context).completionChecklist}', style: AppTextStyle.style14B),
            Consumer<TicktesDetailsController>(
              builder:
                  (context, controller, child) =>
                      TicketDetailsStatus.inprogress.name != controller.ticketsDetails?.status?.toLowerCase() || controller.recording == false
                          ? const SizedBox.shrink()
                          : InkWell(
                            onTap: () async {
                              final result = await context.push('${RouterKey.layout + RouterKey.requestDetails + RouterKey.completionChecklist}?id=$id');
                              if (result is bool) {
                                await context.read<TicktesDetailsController>().ticketDetails(id);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: AppColor.primaryColor)),
                              child: Text(AppText(context).showAll, style: AppTextStyle.style12B.copyWith(color: AppColor.primaryColor)),
                            ),
                          ),
            ),
          ],
        ),
      ],
    );
  }
}
