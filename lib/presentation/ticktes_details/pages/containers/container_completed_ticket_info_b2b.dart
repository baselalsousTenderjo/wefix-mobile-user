import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_cache_network_image.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/model/tickets_details_model.dart';
import '../../domain/ticket_enum.dart';
import '../../widgets/widget_attchmants.dart';

/// B2B-specific completed ticket info container
/// - Hides signature for pending tickets (only shows when completed)
/// - Moves completion note to the end (after signature)
class ContainerCompletedTicketInfoB2B extends StatelessWidget {
  const ContainerCompletedTicketInfoB2B({super.key});

  bool _isCompleted(String? status) {
    if (status == null) return false;
    final ticketStatus = status.toLowerCase();
    return ticketStatus == TicketDetailsStatus.completed.name || ticketStatus == 'ended';
  }

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

            final isCompleted = _isCompleted(controller.ticketsDetails?.status);
            final hasSignature = controller.ticketsDetails?.reportLink != null && 
                controller.ticketsDetails!.reportLink!.isNotEmpty;
            // Completion note is written by technician when completing ticket - only show when completed
            final hasCompletionNote = isCompleted && 
                controller.ticketsDetails?.serviceDescription != null && 
                controller.ticketsDetails!.serviceDescription!.trim().isNotEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ticket Attachments Section
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
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
                      ...regularAttachments.asMap().entries.map((entry) {
                        final index = entry.key;
                        final url = entry.value;
                        final aliasName = 'file-${(index + 1).toString().padLeft(2, '0')}';
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: WidgetAttachmants(url: url, aliasName: aliasName),
                        );
                      }).toList(),
                    ],
                  ),
                20.gap,
                
                // Technician Attachments Section
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
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
                    itemBuilder: (context, index) {
                      final attachment = technicianAttachments[index];
                      final aliasName = 'file-${(index + 1).toString().padLeft(2, '0')}';
                      return WidgetAttachmants(
                        url: attachment.filePath ?? '',
                        aliasName: aliasName,
                      );
                    },
                  ),
                20.gap,
                
                // Signature Section (reportLink) - Only show when ticket is completed
                if (isCompleted) ...[
                  Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                  Row(
                    children: [
                      Icon(Icons.draw, size: 18, color: AppColor.primaryColor),
                      5.gap,
                      Text('${AppText(context).signature}', style: AppTextStyle.style14B),
                    ],
                  ),
                  10.gap,
                  if (!hasSignature)
                    Text(
                      AppText(context).emptyAttachments,
                      style: AppTextStyle.style12.copyWith(color: AppColor.grey),
                    )
                  else
                    InkWell(
                      onTap: () => controller.launchAttachmants(controller.ticketsDetails!.reportLink!),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: WidgetCachNetworkImage(
                            image: controller.ticketsDetails!.reportLink!,
                            boxFit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  20.gap,
                ],
                
                // Completion Note Section - Written by technician when completing ticket, only show when completed
                if (isCompleted && hasCompletionNote) ...[
                  Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                  Row(
                    children: [
                      Icon(Icons.note, size: 18, color: AppColor.primaryColor),
                      5.gap,
                      Text('${AppText(context).completionNote}', style: AppTextStyle.style14B),
                    ],
                  ),
                  10.gap,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.grey.withOpacity(0.3)),
                    ),
                    child: Text(
                      controller.ticketsDetails!.serviceDescription!,
                      style: AppTextStyle.style12.copyWith(height: 1.5, color: AppColor.black),
                    ),
                  ),
                  20.gap,
                ],
              ],
            );
          },
        );
      },
    );
  }
}
