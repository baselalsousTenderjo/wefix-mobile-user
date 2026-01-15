import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_image.dart';
import '../../../core/constant/app_links.dart';
import '../../../core/extension/gap.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/providers/language_provider/l10n_provider.dart';
import '../../../core/router/router_key.dart';
import '../../../core/services/hive_services/box_kes.dart';
import '../../../core/unit/app_color.dart';
import '../../../injection_container.dart';
import '../controller/drawer/drawer_controller.dart';
import '../widgets/widget_list_drawer.dart';
import 'containers/container_drawer_header.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<DrawerControllers>(),
      builder:
          (context, child) => Drawer(
            child: SafeArea(
              child: ListView(
                children: [
                  20.gap,
                  const ContainerDrawerHeader(),
                  5.gap,
                  Divider(color: AppColor.grey.withOpacity(0.5), thickness: 0.5),
                  15.gap,
                  WidgetListDrawer(
                    title: AppText(context).profile,
                    icon: Assets.iconEditProfile,
                    onTap: () => context.push(RouterKey.layout + RouterKey.editProfile),
                  ),
                  Divider(color: AppColor.grey.withOpacity(0.5), thickness: 0.5),
                  WidgetListDrawer(
                    title: AppText(context).notifications,
                    icon: Assets.iconEditNotification,
                    onTap: () => context.push(RouterKey.layout + RouterKey.notification),
                  ),
                  Divider(color: AppColor.grey.withOpacity(0.5), thickness: 0.5),
                  WidgetListDrawer(
                    title: AppText(context).language,
                    icon: Assets.iconLanguage,
                    haveIconArrow: false,
                    onTap: () => context.read<LanguageProvider>().changeLanguage(context),
                  ),
                  Divider(color: AppColor.grey.withOpacity(0.5), thickness: 0.5),
                  WidgetListDrawer(
                    title: AppText(context).privacyPolicy,
                    icon: Assets.iconPrivacy,
                    onTap:
                        () => context.push(
                          '${RouterKey.webview}?url=${_getLanguage(context) == 'en' ? 'https://wefixjo.com/Privacy.html' : 'https://wefixjo.com/Privacy-ar.html'}',
                        ),
                  ),
                  Divider(color: AppColor.grey.withOpacity(0.5), thickness: 0.5),
                  WidgetListDrawer(
                    title: AppText(context).termsConditions,
                    icon: Assets.iconTerms,
                    onTap:
                        () => context.push(
                          '${RouterKey.webview}?url=${_getLanguage(context) == 'en' ? 'https://wefixjo.com/Terms-Conditions.html' : 'https://wefixjo.com/Terms-Conditions-ar.html'}',
                        ),
                  ),
                  Divider(color: AppColor.grey.withOpacity(0.5), thickness: 0.5),
                  WidgetListDrawer(title: AppText(context).logout, icon: Assets.iconLogout, haveIconArrow: false, onTap: () => _logout(context)),
                  25.gap,
                ],
              ),
            ),
          ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final box = sl<Box>(instanceName: BoxKeys.appBox);
    final token = box.get(BoxKeys.usertoken);
    final userTeam = box.get(BoxKeys.userTeam);
    
    // Call logout API to clear token from database
    if (token != null && token.toString().isNotEmpty) {
      try {
        final serverUrl = (userTeam == 'B2B Team') ? AppLinks.serverTMMS : AppLinks.server;
        final dio = Dio();
        await dio.post(
          '$serverUrl${AppLinks.b2bLogout}',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'x-client-type': 'mobile',
              'Content-Type': 'application/json',
            },
          ),
        );
        log('Logout API called successfully');
      } catch (e) {
        log('Error calling logout API: $e');
        // Continue with local logout even if API call fails
      }
    }
    
    // Clear local storage
    box.delete(BoxKeys.enableAuth);
    box.delete(BoxKeys.usertoken);
    box.delete(BoxKeys.userTeam);
    
    if (context.mounted) {
      context.go(RouterKey.login);
    }
  }

  String _getLanguage(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'en') {
      return 'en';
    } else if (locale.languageCode == 'ar') {
      return 'ar';
    } else {
      return 'en';
    }
  }
}
