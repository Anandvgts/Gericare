  // import 'package:doctor/core/constants/images.dart';
  // import 'package:flutter/material.dart';
  // import 'package:flutter_riverpod/flutter_riverpod.dart';
  // import 'package:flutter_screenutil/flutter_screenutil.dart';

  // import 'forgot_password_controller.dart';
  // import 'package:doctor/features/widgets/app_button.dart';
  // import 'package:doctor/features/widgets/auth_back_button.dart';
  // import 'package:doctor/features/widgets/auth_circle_icon.dart';
  // import 'package:doctor/features/widgets/auth_label.dart';
  // import 'package:doctor/features/widgets/auth_input_field.dart';
  // import 'package:doctor/core/styles/text_styles.dart';

  // class ForgotPasswordView extends ConsumerStatefulWidget {
  //   const ForgotPasswordView({super.key});

  //   @override
  //   ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
  // }

  // class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  //   final _controller = TextEditingController();

  //   @override
  //   Widget build(BuildContext context) {
  //     final state = ref.watch(forgotPasswordControllerProvider);
  //     final notifier = ref.read(forgotPasswordControllerProvider.notifier);

  //     return Scaffold(
  //       resizeToAvoidBottomInset: false,
  //       body: SafeArea(
  //         child: Column(
  //           children: [
  //             /// SCROLLABLE CONTENT
  //             Expanded(
  //               child: SingleChildScrollView(
  //                 padding: EdgeInsets.all(24.w),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const AuthBackButton(),
  //                     SizedBox(height: 24.h),
  //                     AuthCircleImage(
  //                       imagePath: Images.forgetPw,
  //                     ),
  //                     SizedBox(height: 24.h),
  //                     Text(
  //                       "Forgot Password",
  //                       style: AppTextStyle.heading24.copyWith(
  //                         fontWeight: FontWeight.w600,
  //                         color: Theme.of(context).colorScheme.primary,
  //                       ),
  //                     ),
  //                     SizedBox(height: 12.h),
  //                     Text(
  //                         "Just enter your registered email/Mobile No, and we’ll send you an OTP to help you reset your password in no time.",
  //                         style: AppTextStyle.bodyText2SubText),
  //                     SizedBox(height: 32.h),
  //                     const AuthLabel("Email ID / Mobile No"),
  //                     AuthInputField(
  //                       controller: _controller,
  //                       error: state.inputError,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),

  //             /// BOTTOM BUTTON
  //             BottomCtaButton(
  //               label: "Get OTP",
  //               isLoading: state.isLoading,
  //               onPressed: () => notifier.getOtp(_controller.text),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }


import 'package:doctor/core/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'forgot_password_controller.dart';
import 'package:doctor/features/widgets/app_button.dart';
import 'package:doctor/features/widgets/auth_back_button.dart';
import 'package:doctor/features/widgets/auth_circle_icon.dart';
import 'package:doctor/features/widgets/auth_label.dart';
import 'package:doctor/features/widgets/auth_input_field.dart';
import 'package:doctor/core/styles/text_styles.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordControllerProvider);
    final controller =
        ref.watch(forgotPasswordControllerProvider.notifier);

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
                    SizedBox(height: 24.h),

                    const AuthCircleImage(
                      imagePath: Images.forgetPw,
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      "Forgot Password",
                      style: AppTextStyle.heading24.copyWith(
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      "Just enter your registered email/Mobile No, and we’ll send you an OTP to help you reset your password in no time.",
                      style: AppTextStyle.bodyText2SubText,
                    ),

                    SizedBox(height: 32.h),

                    const AuthLabel("Email ID / Mobile No"),
                    AuthInputField(
                      controller: controller.inputController,
                      error: controller.inputError,
                    ),
                  ],
                ),
              ),
            ),

            /// BOTTOM BUTTON
            BottomCtaButton(
              label: "Get OTP",
              isLoading: state.isLoading,
              onPressed: controller.getOtp,
            ),
          ],
        ),
      ),
    );
  }
}
