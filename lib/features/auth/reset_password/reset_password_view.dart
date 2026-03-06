
import 'package:doctor/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/auth_back_button.dart';
import 'package:doctor/features/widgets/auth_label.dart';
import 'package:doctor/features/widgets/auth_input_field.dart';
import 'package:doctor/features/widgets/app_button.dart';

import 'reset_password_controller.dart';

class ResetPasswordView extends ConsumerWidget {

  final ResetPasswordArguments args;


  const ResetPasswordView({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(resetPasswordControllerProvider(args));
    final controller = ref.watch(
      resetPasswordControllerProvider(args).notifier,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            /// SCROLLABLE CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthBackButton(),

                    SizedBox(height: 45.h),

                    Text(
                      "Reset Your Password",
                      style: AppTextStyle.heading24.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      "Create a new password to get back on track. Make sure it’s something secure and easy for you to remember.",
                      style: AppTextStyle.bodyText2SubText,
                    ),

                    SizedBox(height: 32.h),

                    const AuthLabel("Create new password"),
                    AuthInputField(
                      controller: controller.newPasswordCtrl,
                      obscureText: controller.obscureNew,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: controller.obscureNew
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixTap:
                          controller.toggleNewPassword,
                      error: controller.newPasswordError,
                    ),

                    SizedBox(height: 24.h),

                    const AuthLabel("Confirm new password"),
                    AuthInputField(
                      controller:
                          controller.confirmPasswordCtrl,
                      obscureText:
                          controller.obscureConfirm,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: controller.obscureConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixTap:
                          controller.toggleConfirmPassword,
                      error:
                          controller.confirmPasswordError,
                    ),
                  ],
                ),
              ),
            ),

            BottomCtaButton(
              label: "Save New Password",
              isLoading: state.isLoading,
              onPressed: controller.resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
