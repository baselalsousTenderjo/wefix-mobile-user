import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_image.dart';
import '../../../core/extension/gap.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../controller/ticktes_details_controller.dart';

class WidgetAttachmants extends StatelessWidget {
  final String url;
  final String? aliasName;
  const WidgetAttachmants({super.key, required this.url, this.aliasName});

  @override
  Widget build(BuildContext context) {
    final displayName = aliasName ?? url.split('/').last;
    return Consumer<TicktesDetailsController>(
      builder:
          (context, controller, child) => InkWell(
            onTap: () => controller.launchAttachmants(url),
            child: Row(
              children: [
                SvgPicture.asset(
                  width: 30,
                  height: 30,
                  url.split('/').last.toLowerCase().contains('mp4')
                      ? Assets.iconMp4
                      : url.split('/').last.toLowerCase().contains('m4a')
                      ? Assets.iconM4a
                      : Assets.iconImage,
                ),
                10.gap,
                Expanded(child: Text(displayName, overflow: TextOverflow.ellipsis, style: AppTextStyle.style10.copyWith(color: AppColor.grey))),
                10.gap,
                const Icon(Icons.visibility, size: 20, color: AppColor.grey),
              ],
            ),
          ),
    );
  }
}
