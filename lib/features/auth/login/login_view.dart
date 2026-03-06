import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_controller.dart';
import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_logo_header.dart';
import 'package:doctor/features/widgets/auth_label.dart';
import 'package:doctor/features/widgets/auth_input_field.dart';
import 'package:doctor/features/widgets/app_button.dart';
import 'package:doctor/router.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.watch(loginControllerProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: AppLogoHeader(showTagline: true),
                    ),
                    SizedBox(height: 36.h),
                    Text(
                      'Welcome Back!',
                      style: AppTextStyle.heading24.copyWith(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Access your task list and stay on top of your patient care responsibilities.',
                      style: AppTextStyle.bodyText1.copyWith(
                        color: context.colors.onSecondaryFixed,
                        height: 1.4,
                        fontSize: 14.h,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    const AuthLabel("User Name"),
                    AuthInputField(
                      controller: controller.usernameController,
                      prefixIcon: Icons.person_outline,
                      error: controller.usernameError,
                    ),
                    SizedBox(height: 20.h),
                    const AuthLabel("Password"),
                    AuthInputField(
                      controller: controller.passwordController,
                      prefixIcon: Icons.lock_outline,
                      obscureText: controller.obscure,
                      suffixIcon: controller.obscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixTap: controller.togglePassword,
                      error: controller.passwordError,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          Routes.forgotPassword,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyle.bodyText1.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.h,
                            color: context.colors.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomCtaButton(
              label: "Login",
              isLoading: state.isLoading,
              onPressed: controller.login,
            ),
          ],
        ),
      ),
    );
  }
}
