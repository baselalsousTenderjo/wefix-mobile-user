import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_image.dart';
import '../../../core/extension/gap.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/services/hive_services/box_kes.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/language_button.dart';
import '../../../injection_container.dart';
import '../controller/auth_provider.dart';
import 'containers/container_form_verify.dart';

class VerifyScreen extends StatelessWidget {
  final String mobile;
  final String? otp;
  final String? team;
  const VerifyScreen({super.key, required this.mobile, this.otp, this.team});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) {
          final provider = sl<AuthProvider>();
          // Set team from URL parameter if available
          if (team != null && team!.isNotEmpty) {
            provider.switchTeam(team!);
            // Also store it in Hive
            try {
              sl<Box>(instanceName: BoxKeys.appBox).put(BoxKeys.userTeam, team!);
            } catch (e) {
              // Silent fail
            }
          }
          return provider;
        },
        child: Consumer<AuthProvider>(
          builder:
              (context, value, child) => Form(
                key: value.otpKey,
                child: SafeArea(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      const Image(image: AssetImage(Assets.imageBacLogin)),
                      Positioned(
                        top: 15,
                        left: 15,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios)), const LanguageButton()],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Center(child: Image(image: AssetImage(Assets.imageLogin))),
                            10.gap,
                            Text(AppText(context).enterOTPtoverifyidentity, style: AppTextStyle.style14),
                            5.gap,
                            Text(mobile.replaceAll(' ', '00'), style: AppTextStyle.style14B),
                            30.gap,
                            ContainerFormVerify(mobile: mobile, otp: otp),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
