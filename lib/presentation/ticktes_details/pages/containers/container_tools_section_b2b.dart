import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../controller/ticktes_details_controller.dart';

/// B2B-specific tools section - hides section if no tools from API
class ContainerToolsSectionB2B extends StatelessWidget {
  final String id;
  const ContainerToolsSectionB2B({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String lang = context.read<LanguageProvider>().lang ?? 'en';
    return Consumer<TicktesDetailsController>(
      builder: (context, controller, child) {
        // Hide section if no tools from API (B2B only)
        if (controller.selecteddTool.value.isEmpty) {
          return const SizedBox.shrink();
        }
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('🪛 ${AppText(context).requiredTools}', style: AppTextStyle.style14B),
                const SizedBox.shrink(),
              ],
            ),
            10.gap,
            ValueListenableBuilder(
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
            20.gap,
          ],
        );
      },
    );
  }
}
