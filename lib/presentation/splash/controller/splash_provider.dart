import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constant/app_image.dart';
import '../../../core/context/global.dart';
import '../../../core/providers/domain/usecase/language_usecase.dart';
import '../../../core/providers/language_provider/l10n_provider.dart';
import '../../../core/router/router_key.dart';
import '../../../core/services/hive_services/box_kes.dart';
import '../../../core/services/version_check_service.dart';
import '../../../injection_container.dart';

class SplashProvider extends ChangeNotifier {
  final LanguageUsecase languageUsecase;

  SplashProvider({required this.languageUsecase}) {
    Future.wait([getLanguage(), insitVedio()]);
  }

  late VideoPlayerController controller;

  Future<void> insitVedio() async {
    controller = VideoPlayerController.asset(Assets.imageWefixMotion)
      ..initialize().then((_) {
        controller.play();
        controller.setLooping(false);
        controller.addListener(() {
          if (controller.value.isInitialized && !controller.value.isPlaying && controller.value.position >= controller.value.duration) {
            getLanguage();
          }
        });
      });
  }

  void init(BuildContext context) async {
    await Future.delayed(const Duration(microseconds: 1000), () async {
      // Check for app update first
      final needsUpdate = await VersionCheckService.checkForUpdate();
      if (needsUpdate) {
        context.go(RouterKey.versionCheck);
        return;
      }
      
      // If no update needed, proceed with normal navigation
      final enableAuth = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.enableAuth);
      if (enableAuth != null) {
        context.go(RouterKey.layout);
      } else {
        context.go(RouterKey.login);
      }
    });
  }

  Future<void> getLanguage() async {
    try {
      // Load languages from local file (no API call)
      final resultTools = await languageUsecase.getLanguage();
      resultTools.fold(
        (failure) {
          // If loading from local file fails, continue without showing error
          // The app will use fallback translations
          log('Failed to load localizations: ${failure.message}');
          init(GlobalContext.context);
        },
        (success) {
          GlobalContext.context.read<LanguageProvider>().addLang(success.data?.languages ?? []);
          notifyListeners();
          init(GlobalContext.context);
        },
      );
    } catch (e) {
      log('Error loading localizations: $e');
      // Continue even if loading fails - fallback translations will be used
      init(GlobalContext.context);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
