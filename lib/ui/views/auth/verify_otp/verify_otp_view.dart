import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'verify_otp_view_model.dart';

import 'package:gericare_doctor/core/res/images.dart';
import 'package:gericare_doctor/core/res/styles.dart';

class VerifyOtpView extends StatelessWidget {
  final OtpFlow flow;

  const VerifyOtpView({
    super.key,
    required this.flow,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ViewModelBuilder<VerifyOtpViewModel>.reactive(
      viewModelBuilder: () => VerifyOtpViewModel(flow: flow)..startTimer(),
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colors.tertiary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: colors.tertiaryFixed,
                  ),
                ),
              ),
            ),
          ),

          /// VERIFY BUTTON
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                onPressed: viewModel.onVerifyOtp,
                child: Text(
                  "Verify OTP",
                  style: AppTextStyle.buttonLabel,
                ),
              ),
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  /// ICON
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary.withOpacity(0.1),
                    ),
                    child: Image.asset(
                      Images.verifyOtp,
                      height: 28,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// TITLE
                  Text(
                    "Verify OTP",
                    style: AppTextStyle.formHeadline.copyWith(
                      color: colors.primary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// DESCRIPTION
                  Text(
                    "We’ve sent a 4-digit code to your registered email.",
                    style: AppTextStyle.bodyText2SubText,
                  ),

                  const SizedBox(height: 32),

                  /// OTP INPUTS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 56,
                        child: TextField(
                          controller: viewModel.controllers[index],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: AppStyle.formFieldDecoration(
                            context,
                            "",
                          ).copyWith(counterText: ""),
                          onChanged: (v) {
                            if (v.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),

                  RichText(
                    text: TextSpan(
                      style: AppTextStyle.bodyText2SubText,
                      children: [
                        const TextSpan(text: "You can resend the code in "),
                        TextSpan(
                          text: "${viewModel.seconds} sec",
                          style: TextStyle(
                            color: context.colors.onSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  InkWell(
                    onTap: viewModel.canResend ? viewModel.onResendOtp : null,
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                        color: viewModel.canResend
                            ? context.colors.primaryFixed
                            : context.colors.secondaryFixed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
