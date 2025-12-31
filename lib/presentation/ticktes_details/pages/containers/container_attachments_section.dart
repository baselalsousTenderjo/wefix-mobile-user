import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/app_image.dart';
import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';
import '../../widgets/widget_attchmants.dart';

class ContainerAttachmentsSection extends StatelessWidget {
  const ContainerAttachmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicktesDetailsController>(
      builder: (context, controller, child) {
        // Only show regular attachments (ticketAttatchments + ticketImages), excluding technician attachments
        final regularAttachments = <String>[];
        
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
              regularAttachments.add(imageUrl);
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
              regularAttachments.add(url);
            }
          }
        }
        
        final hasAttachments = regularAttachments.isNotEmpty;
        
        return ValueListenableBuilder(
          valueListenable: controller.ticketStatue,
          builder: (context, value, child) {
            // Always show the section, even when loading or empty
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    if (value == TicketStatus.success && hasAttachments)
                      InkWell(
                        onTap: () => controller.showAttachmant(context),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.primaryColor, width: 1)),
                          child: SvgPicture.asset(Assets.iconAttachmant),
                        ),
                      ),
                  ],
                ),
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                10.gap,
                if (value == TicketStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (regularAttachments.isEmpty)
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
              ],
            );
          },
        );
      },
    );
  }
}
