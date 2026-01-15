import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:go_router/go_router.dart';

import '../../context/global.dart';
import '../../services/hive_services/box_kes.dart';
import '../../router/router_key.dart';
import '../../../injection_container.dart';

/// Force logout user when account is deactivated or token is invalid
Future<void> forceLogout() async {
  try {
    // Schedule logout after current frame is built to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final box = sl<Box>(instanceName: BoxKeys.appBox);
        final userBox = sl<Box>(instanceName: BoxKeys.userData);
        
        // Clear all user data and tokens
        await box.delete(BoxKeys.usertoken);
        await box.delete('${BoxKeys.usertoken}_refresh');
        await box.delete('${BoxKeys.usertoken}_expiresAt');
        await box.delete(BoxKeys.enableAuth);
        await box.delete(BoxKeys.userTeam);
        await userBox.delete(BoxKeys.userData);

        // Navigate to login screen
        final context = GlobalContext.context;
        if (context.mounted) {
          context.go(RouterKey.login);
        }
      } catch (e) {
        log('Error during force logout: $e');
      }
    });
  } catch (e) {
    log('Error scheduling force logout: $e');
  }
}
