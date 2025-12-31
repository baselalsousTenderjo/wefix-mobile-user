import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/app_text.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../injection_container.dart';
import '../../drawer/pages/drawer.dart';
import '../../home/controller/home_controller.dart';
import '../controller/layout_provider.dart';
import '../widgets/widget_appbar.dart';

class LayoutScreen extends StatelessWidget {
  final int? index;
  const LayoutScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<HomeController>()..checkAccess(),
      child: Scaffold(
      appBar: WidgetAppbar.appBar(context),
      drawer: const DrawerWidget(),
      body: context.read<LayoutProvider>().screens[context.watch<LayoutProvider>().currentIndex],
      bottomNavigationBar: Consumer<LayoutProvider>(
        builder: (context, value, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (value.items.length < 2 || value.items[0].label != AppText(context, isFunction: true).home) {
              value.setBottomNavBar( );
            }
          });
          if (value.items.length < 2) {
            return const SizedBox.shrink();
          }
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: value.currentIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            selectedLabelStyle: AppTextStyle.style14B,
            items: value.items,
            onTap: value.changeIndex,
          );
        },
        ),
      ),
    );
  }
}
