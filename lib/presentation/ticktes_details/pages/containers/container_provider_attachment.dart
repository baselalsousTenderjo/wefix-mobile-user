import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/model/tickets_details_model.dart';
import '../../domain/ticket_enum.dart';
import '../../widgets/widget_attchmants.dart';

class ContainerProviderAttachment extends StatelessWidget {
  final String id;
  const ContainerProviderAttachment({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder: (context, value, child) {
        final rawStatus = value.ticketsDetails?.status?.toLowerCase() ?? '';
        final ticketStatus = rawStatus.replaceAll(' ', '');
        final isCompleted = ticketStatus == TicketDetailsStatus.completed.name || ticketStatus == 'ended';
        
            // Handle both null and empty array cases from backend
            // Deduplicate technician attachments by filePath
            final allTechnicianAttachments = value.ticketsDetails?.technicianAttachments ?? [];
            final uniqueTechnicianAttachments = <String, TicketAttatchment>{};
            
            // Use a Map to deduplicate by filePath (URL)
            for (var attachment in allTechnicianAttachments) {
              final filePath = attachment.filePath ?? '';
              if (filePath.isNotEmpty && !uniqueTechnicianAttachments.containsKey(filePath)) {
                uniqueTechnicianAttachments[filePath] = attachment;
              }
            }
            
            final technicianAttachments = uniqueTechnicianAttachments.values.toList();
            final hasTechnicianAttachments = technicianAttachments.isNotEmpty;
        
        return ValueListenableBuilder(
          valueListenable: value.ticketStatue,
          builder: (context, status, child) {
            // Always show the section, even when loading or empty
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_file, size: 18, color: AppColor.primaryColor),
                        5.gap,
                        Text('${AppText(context).technicianAttachments}', style: AppTextStyle.style14B),
                      ],
                    ),
                    // Only show add button if ticket is not completed and not loading
                    if (!isCompleted && status != TicketStatus.loading)
                      InkWell(
                        onTap: () => value.selectMethodForImage(isAdd: true, ticketId: id),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.primaryColor, width: 1)),
                          child: Icon(Icons.add, color: AppColor.primaryColor, size: 20),
                        ),
                      ),
                  ],
                ),
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                10.gap,
                if (status == TicketStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (!hasTechnicianAttachments)
                  Text(
                    AppText(context).emptyAttachments,
                    style: AppTextStyle.style12.copyWith(color: AppColor.grey),
                  )
                else
                  ListView.separated(
                    itemCount: technicianAttachments.length,
                    separatorBuilder: (context, index) => 10.gap,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => WidgetAttachmants(
                      url: technicianAttachments[index].filePath ?? '',
                    ),
                  ),
                20.gap,
              ],
            );
          },
        );
      },
    );
  }
}
