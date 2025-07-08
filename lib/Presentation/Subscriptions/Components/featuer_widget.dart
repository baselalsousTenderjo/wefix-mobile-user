import 'package:flutter/material.dart';
import 'package:wefix/Data/Constant/theme/color_constant.dart';
import 'package:wefix/Data/Functions/app_size.dart';

class FeatureWidget extends StatefulWidget {
  final String? feature;
  final String? value;
  final Color? color;

  const FeatureWidget({
    super.key,
    this.feature,
    this.value,
    this.color,
  });

  @override
  State<FeatureWidget> createState() => _FeatureWidgetState();
}

class _FeatureWidgetState extends State<FeatureWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          SizedBox(
            width: AppSize(context).width * 0.45,
            child: Text(
              "⭐  ${widget.feature ?? ''}",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Center(
            child: SizedBox(
              width: AppSize(context).width * .15,
              child: Text(
                widget.value ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.blackColor1,
                  fontSize: AppSize(context).smallText2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
