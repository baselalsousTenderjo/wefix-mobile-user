import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/app_image.dart';
import '../../../../core/extension/gap.dart';
import '../../../../core/loading/loading_tickets.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_loading.dart';
import '../../controller/home_controller.dart';
import '../../domain/home_enum.dart';
import '../../widgets/widget_card_requests.dart';
import '../../widgets/widget_home_filter.dart';

class ContainerOrdersRequiest extends StatelessWidget {
  const ContainerOrdersRequiest({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return ValueListenableBuilder(
          valueListenable: context.read<HomeController>().homeStatue,
          builder:
              (context, value, child) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Row(
                    children: [
                      5.gap,
                      Consumer<HomeController>(
                        builder: (context, controller, child) {
                          switch (value) {
                            case HomeStatus.loading:
                              return const WidgetLoading(width: 20);
                            case HomeStatus.success:
                              return Row(
                                children: [
                                  InkWell(onTap: () => controller.showStatusColorDialog(context), child: const Icon(Icons.info, color: AppColor.primaryColor600)),
                                  10.gap,
                                  Text(AppText(context).pendingTicktes, style: AppTextStyle.style14B),
                                  3.gap,
                                  Text('(${controller.totalTickets})', style: AppTextStyle.style12B),
                                ],
                              );
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                  const WidgetHomeFilter(),
                  Consumer<HomeController>(
                    builder: (context, controller, child) {
                      switch (value) {
                        case HomeStatus.loading:
                          return const LoadingTickets();
                        case HomeStatus.success:
                          if (controller.filterTypes.where((tickets) => tickets['isSelected'] == true).first['data'].isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  50.gap,
                                  SvgPicture.asset(Assets.iconTickets, width: 120, height: 120, color: AppColor.secondColor.withOpacity(0.5)),
                                  15.gap,
                                  Text(AppText(context).noAssignedTickets, style: AppTextStyle.style22B.copyWith(color: AppColor.primaryColor)),
                                ],
                              ),
                            );
                          } else {
                            return ListView.separated(
                              itemCount: controller.filterTypes.where((tickets) => tickets['isSelected'] == true).first['data'].length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => 5.gap,
                              itemBuilder:
                                  (context, index) =>
                                      WidgetCardRequests(tickets: controller.filterTypes.where((tickets) => tickets['isSelected'] == true).first['data'][index]),
                            );
                          }

                        case HomeStatus.failuer:
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                50.gap,
                                SvgPicture.asset(Assets.iconTickets, width: 120, height: 120, color: AppColor.red.withOpacity(0.5)),
                                15.gap,
                                Text(AppText(context).systemUnavailablePleaseTryAgainLater, 
                                  style: AppTextStyle.style16.copyWith(color: AppColor.red),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
          );
        },
      );
    }
  }
