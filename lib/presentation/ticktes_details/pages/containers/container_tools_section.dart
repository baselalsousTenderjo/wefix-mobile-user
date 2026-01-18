import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../controller/ticktes_details_controller.dart';
// import '../../domain/ticket_enum.dart'; // Not needed after hiding add button

class ContainerToolsSection extends StatelessWidget {
  final String id;
  const ContainerToolsSection({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String lang = context.read<LanguageProvider>().lang ?? 'en';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('🪛 ${AppText(context).requiredTools}', style: AppTextStyle.style14B),
            // Hidden: Add button for tools
            // TicketDetailsStatus.completed.name == context.read<TicktesDetailsController>().ticketsDetails?.status?.toLowerCase()
            //     ? const SizedBox.shrink()
            //     : InkWell(
            //       onTap: () {
            //         context.read<TicktesDetailsController>().getTools(
            //           context,
            //           id,
            //           context.read<TicktesDetailsController>().selecteddTool.value.map((e) => e.id ?? 0).toList(),
            //         );
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.all(5),
            //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.primaryColor, width: 1)),
            //         child: Icon(Icons.add, size: 20, color: AppColor.primaryColor),
            //       ),
            //     ),
            const SizedBox.shrink(),
          ],
        ),
        10.gap,
        Consumer<TicktesDetailsController>(
          builder:
              (context, controller, child) => ValueListenableBuilder(
                valueListenable: controller.selecteddTool,
                builder:
                    (context, value, child) => Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children:
                          value
                              .map(
                                (tool) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(.2), borderRadius: BorderRadius.circular(5)),
                                  child: Text(lang == 'ar' ? tool.titleAr ?? '' : tool.title ?? '', style: AppTextStyle.style12),
                                ),
                              )
                              .toList(),
                    ),
              ),
        ),
        20.gap,
      ],
    );
  }
}
