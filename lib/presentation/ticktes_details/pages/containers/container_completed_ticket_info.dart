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

class ContainerCompletedTicketInfo extends StatelessWidget {
  const ContainerCompletedTicketInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder: (context, controller, child) {
        return ValueListenableBuilder(
          valueListenable: controller.ticketStatue,
          builder: (context, value, child) {
            // Always show the section for all tickets
            if (value == TicketStatus.loading) {
              return const SizedBox.shrink();
            }

            // Get ticket attachments (ticketAttatchments + ticketImages), excluding technician attachments
            // Use a Set to prevent duplicates within ticket attachments
            final regularAttachmentsSet = <String>{};
            
            // Get technician attachment URLs to exclude duplicates
            final technicianUrls = controller.ticketsDetails?.technicianAttachments
                ?.map((a) => a.filePath ?? '')
                .where((url) => url.isNotEmpty)
                .toSet() ?? <String>{};
            
            // Add ticket images (excluding those already in technicianAttachments)
            // Handle both null and empty array cases
            final ticketImages = controller.ticketsDetails?.ticketImages ?? [];
            if (ticketImages.isNotEmpty) {
              for (var imageUrl in ticketImages) {
                if (imageUrl.isNotEmpty && !technicianUrls.contains(imageUrl)) {
                  regularAttachmentsSet.add(imageUrl);
                }
              }
            }
            
            // Add regular attachments (excluding those already in technicianAttachments)
            // Handle both null and empty array cases
            final ticketAttachments = controller.ticketsDetails?.ticketAttatchments ?? [];
            if (ticketAttachments.isNotEmpty) {
              for (var attachment in ticketAttachments) {
                final url = attachment.filePath ?? '';
                if (url.isNotEmpty && !technicianUrls.contains(url)) {
                  regularAttachmentsSet.add(url);
                }
              }
            }
            
            // Convert Set to List for display
            final regularAttachments = regularAttachmentsSet.toList();
            final hasRegularAttachments = regularAttachments.isNotEmpty;
            
            // Get technician attachments and deduplicate by filePath
            final allTechnicianAttachments = controller.ticketsDetails?.technicianAttachments ?? [];
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ticket Attachments Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_file, size: 18, color: AppColor.primaryColor),
                        5.gap,
                        Text('${AppText(context).ticketAttachments}', style: AppTextStyle.style14B),
                      ],
                    ),
                  ],
                ),
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                10.gap,
                if (!hasRegularAttachments)
                  Text(
                    AppText(context).emptyAttachments,
                    style: AppTextStyle.style12.copyWith(color: AppColor.grey),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...regularAttachments.map((url) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: WidgetAttachmants(url: url),
                        );
                      }).toList(),
                    ],
                  ),
                20.gap,
                
                // Technician Attachments Section
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
                  ],
                ),
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                10.gap,
                if (!hasTechnicianAttachments)
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

