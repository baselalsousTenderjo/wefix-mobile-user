import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/app_image.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/services/hive_services/box_kes.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_cache_network_image.dart';
import '../../../../core/widget/widget_loading.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/model/user_model.dart';
import '../../controller/home_controller.dart';
import '../../domain/home_enum.dart';
import '../../widgets/widget_rating.dart';

/// B2C Home Card - Shows user profile image, rating, and reviews
/// This is the original version for WeFix Team (B2C)
class ContainerHomeCardB2C extends StatelessWidget {
  const ContainerHomeCardB2C({super.key});

  @override
  Widget build(BuildContext context) {
    String lang = context.read<LanguageProvider>().lang ?? 'en';
    return ValueListenableBuilder(
      valueListenable: sl<Box<User>>().listenable(),
      builder: (context, value, child) {
        User? user = value.get(BoxKeys.userData);
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColor.grey.withOpacity(0.4), width: 1)),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              SvgPicture.asset(Assets.iconHomeCard),
              Container(
                margin: EdgeInsetsDirectional.only(end: lang == 'ar' ? 0 : 20, start: lang == 'ar' ? 20 : 00),
                width: 100,
                height: 100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000)),
                child:
                    user?.image == null || user?.image == ''
                        ? Image.asset(Assets.imageUser)
                        : WidgetCachNetworkImage(radius: 1000, boxFit: BoxFit.cover, image: user?.image ?? ''),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('${user?.rating ?? 0.0}', style: AppTextStyle.style26B),
                          Consumer<HomeController>(
                            builder:
                                (context, controller, child) => ValueListenableBuilder(
                                  valueListenable: controller.homeStatue,
                                  builder: (context, value, child) {
                                    switch (value) {
                                      case HomeStatus.loading:
                                        return const WidgetLoading(width: 60, top: 10);
                                      case HomeStatus.success:
                                        // For B2C, show simple rating display
                                        return Column(
                                          children: [
                                            WidgetRating(rating: 4.5), // Default rating for B2C
                                            Text(AppText(context).reviews, style: AppTextStyle.style16),
                                          ],
                                        );
                                      default:
                                        return const SizedBox.shrink();
                                    }
                                  },
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
