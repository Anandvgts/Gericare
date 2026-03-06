import 'package:doctor/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'verify_otp_controller.dart';
import 'package:doctor/core/styles/theme.dart';
import 'package:doctor/core/constants/images.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/auth_circle_icon.dart';
import 'package:doctor/features/widgets/auth_back_button.dart';
import 'package:doctor/features/widgets/app_button.dart';

class VerifyOtpView extends ConsumerWidget {
  final VerifyOtpArguments args;

  const VerifyOtpView({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verifyOtpControllerProvider(args));
    final controller = ref.watch(verifyOtpControllerProvider(args).notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthBackButton(),
                    SizedBox(height: 24.h),

                    const AuthCircleImage(
                      imagePath: Images.verifyOtp,
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      "Verify OTP",
                      style: AppTextStyle.heading24.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      "We’ve sent a 6-digit code to your registered email.",
                      style: AppTextStyle.bodyText2SubText,
                    ),

                    SizedBox(height: 32.h),

                    /// OTP INPUTS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (i) {
                        return SizedBox(
                          width: 48.w,
                          child: TextField(
                            controller: controller.controllers[i],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: AppStyle.otpDecoration(context),
                            onChanged: (_) => controller.onOtpChanged(
                              context: context,
                              index: i,
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 24.h),

                    /// TIMER
                    RichText(
                      text: TextSpan(
                        style: AppTextStyle.bodyText2SubText,
                        children: [
                          const TextSpan(
                            text: "You can resend the code in ",
                          ),
                          TextSpan(
                            text: "${controller.seconds} sec",
                            style: TextStyle(
                              color: controller.seconds == 0
                                  ? context.colors.outline
                                  : context.colors.onSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    if (controller.seconds == 0)
                      GestureDetector(
                        onTap: controller.resendOtp,
                        child: Text(
                          "Resend code",
                          style: TextStyle(
                            color: context.colors.onSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            BottomCtaButton(
              label: "Verify OTP",
              isLoading: state.isLoading,
              onPressed: controller.verifyOtp,
            ),
          ],
        ),
      ),
    );
  }
}
