import 'package:flutter/material.dart';

import '../../../core/extension/gap.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/widget_loading.dart';

class WidgetRecordMaintenSection extends StatelessWidget {
  final String title;
  final String title2;
  final String value;
  final String? value2;
  final Widget? value2Widget;
  final bool? loading;

  const WidgetRecordMaintenSection({
    super.key, 
    required this.title, 
    required this.title2, 
    required this.value, 
    this.value2,
    this.value2Widget,
    this.loading = false,
  }) : assert(value2 != null || value2Widget != null, 'Either value2 or value2Widget must be provided');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.style12B),
              5.gap,
              loading == true
                  ? const WidgetLoading(width: 60)
                  : Expanded(
                      child: Text(
                        value, 
                        textAlign: TextAlign.start, 
                        maxLines: null,
                        softWrap: true,
                        style: AppTextStyle.style12,
                      ),
                    ),
            ],
          ),
        ),
        6.gap,
        Container(height: 20, width: 1, decoration: BoxDecoration(color: Colors.grey.withOpacity(.4), borderRadius: BorderRadius.circular(5))),
        10.gap,
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Text(title2, style: AppTextStyle.style12B)),
              5.gap,
              loading == true 
                  ? const WidgetLoading(width: 60) 
                  : value2Widget != null
                      ? value2Widget!
                      : Expanded(
                          child: Text(
                            value2 ?? '', 
                            textAlign: TextAlign.start,
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
