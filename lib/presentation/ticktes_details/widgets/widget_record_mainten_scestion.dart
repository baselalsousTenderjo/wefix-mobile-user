import 'package:flutter/material.dart';

import '../../../core/extension/gap.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/widget_loading.dart';

class WidgetRecordMaintenSection extends StatelessWidget {
  final String title;
  final String title2;
  final String value;
  final String value2;
  final bool? loading;

  const WidgetRecordMaintenSection({super.key, required this.title, required this.title2, required this.value, required this.value2, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Text(title, style: AppTextStyle.style12B)),
              5.gap,
              loading == true
                  ? const WidgetLoading(width: 60)
                  : Expanded(
                      child: Text(
                        value, 
                        textAlign: TextAlign.end, 
                        maxLines: null,
                        softWrap: true,
                        style: AppTextStyle.style12,
                      ),
                    ),
            ],
          ),
        ),
        10.gap,
        Container(height: 20, width: 1, decoration: BoxDecoration(color: Colors.grey.withOpacity(.4), borderRadius: BorderRadius.circular(5))),
        10.gap,
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Text(title2, style: AppTextStyle.style12B)),
              5.gap,
              loading == true 
                  ? const WidgetLoading(width: 60) 
                  : Expanded(
                      child: Text(
                        value2, 
                        textAlign: TextAlign.end,
                        maxLines: null,
                        softWrap: true,
                        style: AppTextStyle.style12,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
