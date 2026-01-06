import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:stacked/stacked.dart';
import 'reset_password_view_model.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordViewModel(),
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

          /// SAVE BUTTON
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                onPressed: viewModel.onSavePassword,
                child: Text(
                  "Save New Password",
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

                    /// TITLE
                    Text(
                      "Reset Your Password",
                      style: AppTextStyle.formHeadline.copyWith(
                        color: colors.primary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// DESCRIPTION
                    Text(
                      "Create a new password to get back on track. Make sure it’s something secure and easy for you to remember.",
                      style: AppTextStyle.bodyText2SubText,
                    ),

                    const SizedBox(height: 32),

                    /// NEW PASSWORD
                    Text(
                      "Create new password",
                      style: AppTextStyle.labelTextStyle
                          .copyWith(color: colors.primaryFixed),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: viewModel.newPasswordController,
                      validator: viewModel.validateNewPassword,
                      obscureText: viewModel.obscureNewPassword,
                      decoration: AppStyle.formFieldDecoration(
                        context,
                        "Enter",
                      ).copyWith(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: colors.outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            viewModel.obscureNewPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: colors.outline,
                          ),
                          onPressed:
                              viewModel.toggleNewPasswordVisibility,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// CONFIRM PASSWORD
                    Text(
                      "Confirm new password",
                      style: AppTextStyle.labelTextStyle
                          .copyWith(color: colors.primaryFixed),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: viewModel.confirmPasswordController,
                      validator: viewModel.validateConfirmPassword,
                      obscureText: viewModel.obscureConfirmPassword,
                      decoration: AppStyle.formFieldDecoration(
                        context,
                        "Enter",
                      ).copyWith(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: colors.outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            viewModel.obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: colors.outline,
                          ),
                          onPressed:
                              viewModel.toggleConfirmPasswordVisibility,
                        ),
                      ),
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
