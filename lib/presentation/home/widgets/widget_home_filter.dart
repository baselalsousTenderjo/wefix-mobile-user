import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/language_provider/l10n_provider.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../controller/home_controller.dart';

class WidgetHomeFilter extends StatelessWidget {
  const WidgetHomeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        // Update filter titles when language changes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<HomeController>().updateFilterTitlesForLanguageChange();
        });
        
        return Consumer<HomeController>(
          builder: (context, value, child) {
            return Wrap(
              spacing: 5.0,
              children:
                  value.filterTypes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final e = entry.value;
                    return ChoiceChip(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      selectedColor: e['isSelected'] == true ? AppColor.primaryColor : AppColor.white,
                      labelStyle: AppTextStyle.style10.copyWith(color: e['isSelected'] == true ? AppColor.white : AppColor.black),
                      label: Text('${e['title']} (${e['count']})'),
                      checkmarkColor: AppColor.white,
                      selected: e['isSelected'],
                      onSelected: (_) => value.changeType(index, context),
                    );
                  }).toList(),
            );
          },
        );
      },
    );
  }
}
