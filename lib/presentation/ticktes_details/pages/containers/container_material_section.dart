import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/router/router_key.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';
import '../../widgets/widget_product.dart';

class ContainerMaterialSection extends StatelessWidget {
  final String id;
  const ContainerMaterialSection({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('🔧 ${AppText(context).requiredMaterial}', style: AppTextStyle.style14B),
            InkWell(
              onTap: () async {
                final result = await context.push('${RouterKey.layout + RouterKey.requestDetails + RouterKey.selectProduct}?id=$id');
                if (result is bool) {
                  context.read<TicktesDetailsController>().ticketDetails(id);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: AppColor.primaryColor)),
                child: Text(AppText(context).add, style: AppTextStyle.style12B.copyWith(color: AppColor.primaryColor)),
              ),
            ),
          ],
        ),
        Consumer<TicktesDetailsController>(
          builder:
              (context, provider, child) => ValueListenableBuilder(
                valueListenable: provider.selectedMaterial,
                builder:
                    (context, value, child) =>
                        context.read<TicktesDetailsController>().ticketStatue.value == TicketStatus.loading
                            ? const SizedBox.shrink()
                            : value.isEmpty
                            ? Center(
                              child: Column(
                                children: [
                                  10.gap,
                                  Text(' 🔧 ${AppText(context).nomaterialaddedyet}', style: AppTextStyle.style14B.copyWith(color: AppColor.red)),
                                ],
                              ),
                            )
                            : ListView.separated(
                              itemCount: value.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => 5.gap,
                              itemBuilder: (context, index) => WidgetProduct(material: value[index], index: index),
                            ),
              ),
        ),
        20.gap,
      ],
    );
  }
}
