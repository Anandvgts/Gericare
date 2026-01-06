import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/images.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:stacked/stacked.dart';
import 'forgot_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
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
                    color: context.colors.tertiary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: context.colors.tertiaryFixed,
                  ),
                ),
              ),
            ),
          ),

          /// BUTTON AT BOTTOM
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
                onPressed: viewModel.onGetOtp,
                child: Text(
                  "Get OTP",
                  style: AppTextStyle.buttonLabel,
                ),
              ),
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    /// CIRCULAR IMAGE CONTAINER
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.primary.withOpacity(0.1),
                      ),
                      child: Image.asset(
                        Images.forgetPw, // your image
                        height: 28,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// TITLE
                    Text(
                      "Forgot Password",
                      style: AppTextStyle.formHeadline.copyWith(
                        color: colors.primary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// DESCRIPTION
                    Text(
                      "Just enter your registered email/Mobile No, and we’ll send you an OTP to help you reset your password in no time.",
                      style: AppTextStyle.bodyText2SubText,
                    ),

                    const SizedBox(height: 24),

                    /// INPUT LABEL
                    Text(
                      "Email ID / Mobile No",
                      style: AppTextStyle.labelTextStyle
                          .copyWith(color: context.colors.primaryFixed),
                    ),
                    const SizedBox(height: 6),

                    /// INPUT FIELD
                    TextFormField(
                      controller: viewModel.emailOrMobileController,
                      validator: viewModel.validateEmailOrMobile,
                      decoration:
                          AppStyle.formFieldDecoration(context, "Enter"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
