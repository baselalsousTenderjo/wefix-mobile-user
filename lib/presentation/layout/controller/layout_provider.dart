// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constant/app_image.dart';
import '../../../core/context/global.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/services/hive_services/box_kes.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/widget/widget_daialog.dart';
import '../../../injection_container.dart';
import '../../auth/domain/model/user_model.dart';
import '../../home/pages/home_screen.dart';
import '../../scan/pages/scan_screen.dart';
import '../../support/pages/support_screen.dart';
import '../../tools/pages/tools_screen.dart';
import '../domain/model/notification_model.dart';
import '../domain/notification_enum.dart';
import '../domain/usecase/layout_usecase.dart';

class LayoutProvider extends ChangeNotifier with WidgetsBindingObserver {
  final LayoutUsecase notificationUseCase;

  ValueNotifier<NotificationState> notificationState = ValueNotifier(NotificationState.init);
  List<BottomNavigationBarItem> items = [];
  List<Widget> screens = [];
  int currentIndex = 0;

  LayoutProvider({required this.notificationUseCase}) {
    // Initialize navigation bar on creation
    setBottomNavBar();
  }

  // Helper method to check if user is B2B Team
  bool _isB2BTeam() {
    try {
      final userTeam = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
      return userTeam == 'B2B Team';
    } catch (e) {
      return false; // Default to B2C if error
    }
  }

  void setBottomNavBar() {
    final bool isB2B = _isB2BTeam();
    
    // Build screens list - only Home for B2B, all screens for B2C
    if (isB2B) {
      screens = [const HomeScreen()];
    } else {
      screens = [const HomeScreen(), const ScanScreen(), const ToolsScreen(), const SupportScreen()];
    }
    
    // Build navigation items - only Home for B2B, all items for B2C
    if (isB2B) {
      // B2B: Only show Home tab
      items = [
        BottomNavigationBarItem(
          label: AppText(GlobalContext.context, isFunction: true).home,
          icon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconHome)),
          activeIcon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconHome, color: AppColor.primaryColor)),
        ),
      ];
    } else {
      // B2C: Show all tabs (Home, Scan, Tools, Support)
      items = [
        BottomNavigationBarItem(
          label: AppText(GlobalContext.context, isFunction: true).home,
          icon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconHome)),
          activeIcon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconHome, color: AppColor.primaryColor)),
        ),
        BottomNavigationBarItem(
          label: AppText(GlobalContext.context, isFunction: true).scan,
          icon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconScan, color: AppColor.grey)),
          activeIcon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconScan, color: AppColor.primaryColor)),
        ),
        BottomNavigationBarItem(
          label: AppText(GlobalContext.context, isFunction: true).tools,
          icon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconTools, color: AppColor.grey)),
          activeIcon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconTools, color: AppColor.primaryColor)),
        ),
        BottomNavigationBarItem(
          label: AppText(GlobalContext.context, isFunction: true).support,
          icon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconSupport, color: AppColor.grey)),
          activeIcon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(Assets.iconSupport, color: AppColor.primaryColor)),
        ),
      ];
    }

    // Ensure currentIndex is valid for the new screens list
    final maxIndex = screens.length - 1;
    if (currentIndex > maxIndex) {
      currentIndex = 0; // Reset to Home if index is out of bounds
    }

    notifyListeners();
  }

  // * Function to change the current index of the bottom navigation bar
  void changeIndex(int index) {
    // The screens list and items list are already aligned (Tools excluded for B2B)
    // So the index maps directly to the screen index
    currentIndex = index;
    notifyListeners();
  }

  // * Function to get the current index of the bottom navigation bar
  void setCurrentIndex(int? index) {
    if (index != null) {
      final bool isB2B = _isB2BTeam();
      
      // Ensure index is within bounds for current screen list
      // For B2B: screens are [Home(0), Scan(1), Support(2)] - max index is 2
      // For B2C: screens are [Home(0), Scan(1), Tools(2), Support(3)] - max index is 3
      final maxIndex = isB2B ? 2 : 3;
      
      // If B2B user tries to access Tools (index 2 from B2C routing), redirect to Support
      // If index is out of bounds, clamp it to valid range
      if (isB2B && index >= 2) {
        currentIndex = 2; // Support is at index 2 in B2B screens list
      } else {
        currentIndex = index.clamp(0, maxIndex);
      }
      notifyListeners();
    }
  }

  // * Function Get Notifivation
  NotificationModel? notificationModel;
  Future<void> getNotification() async {
    try {
      notificationState.value = NotificationState.loading;
      final notificationResponse = await notificationUseCase.getNotifications();
      notificationResponse.fold(
        (failure) {
          notificationState.value = NotificationState.failure;
          notifyListeners();
        },
        (notification) {
          if (notification.data?.notification?.isEmpty ?? true) {
            notificationState.value = NotificationState.empty;
          } else {
            notificationState.value = NotificationState.success;
          }
          notificationModel = notification.data;
          notifyListeners();
        },
      );
    } catch (e) {
      notificationState.value = NotificationState.failure;
      log('Server Error In Notification Section : $e');
      notifyListeners();
    }
  }

  // * Function Get Profile
  Future<void> getProfile() async {
    try {
      final result = await notificationUseCase.profile();
      result.fold((failure) {}, (profile) {
        sl<Box<User>>().put(BoxKeys.userData, profile.data!);
      });
    } catch (e) {
      log('Server Error In Profile Section : $e');
      SmartDialog.show(
        builder:
            (context) => WidgetDilog(
              isError: true,
              title: AppText(context).warning,
              message: 'Server Error In Profile Section : $e',
              cancelText: AppText(context).back,
              onCancel: () => SmartDialog.dismiss(),
            ),
      );
    }
  }
}
