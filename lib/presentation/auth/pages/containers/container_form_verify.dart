import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/mixin/validation_mixin.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/button/app_button.dart';
import '../../controller/auth_provider.dart';
import '../../domain/auth_enum.dart';
import '../../widgets/widget_resend_code.dart';

class ContainerFormVerify extends StatefulWidget with FormValidationMixin {
  final String mobile;
  final String? otp;
  ContainerFormVerify({super.key, required this.mobile, this.otp});

  @override
  State<ContainerFormVerify> createState() => _ContainerFormVerifyState();
}

class _ContainerFormVerifyState extends State<ContainerFormVerify> with FormValidationMixin {

  @override
  void initState() {
    super.initState();
    // Auto-fill OTP if provided (from response in development mode)
    if (widget.otp != null && widget.otp!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final authProvider = context.read<AuthProvider>();
        authProvider.otp.text = widget.otp!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Pinput(
            autofocus: true,
            showCursor: true,
            length: 4,
            validator: (value) => validateNull(context, value),
            hapticFeedbackType: HapticFeedbackType.mediumImpact,
            controller: context.read<AuthProvider>().otp,
            // Enable SMS autofill - pinput automatically handles SMS autofill on Android
            // Note: onCompleted is removed - user must manually press verify button
            // Enable paste functionality
            enableSuggestions: true,
            // Keyboard type for OTP
            keyboardType: TextInputType.number,
            // Enable SMS autofill hint
            autofillHints: const [AutofillHints.oneTimeCode],
          ),
        ),
        30.gap,
        Text(AppText(context).donotreceivethecodeyet, style: AppTextStyle.style12.copyWith(color: AppColor.black)),
        10.gap,
        WidgetResendCode(mobile: widget.mobile),
        30.gap,
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValueListenableBuilder(
                  valueListenable: context.read<AuthProvider>().sendOTPState,
                  builder:
                      (context, value, child) => AppButton.text(
                        text: AppText(context).veirfy,
                        loading: value == SendState.loading,
                        onPressed: () async => await context.read<AuthProvider>().sendOTP(widget.mobile),
                      ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
