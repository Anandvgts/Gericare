import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/images.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:stacked/stacked.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, _) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            bottomNavigationBar:

                /// LOGIN BUTTON
                Padding(
              padding:
                  EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 16),
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    viewModel.onLogin();
                  },
                  child: Text(
                    "Login",
                    style: AppTextStyle.buttonLabel,
                  ),
                ),
              ),
            ),
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Form(
                        key: viewModel.formKey,
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// LOGO
                              Center(
                                child: Image.asset(
                                  Images.appLogo,
                                  height: 48,
                                ),
                              ),

                              const SizedBox(height: 32),

                              /// TITLE
                              Text(
                                "Welcome Back !",
                                style: AppTextStyle.formHeadline.copyWith(
                                  color: context.colors.primary,
                                ),
                              ),

                              const SizedBox(height: 8),

                              /// SUBTITLE
                              Text(
                                "Access your task list and stay on top of your patient care responsibilities.",
                                style: AppTextStyle.bodyText2SubText,
                              ),

                              const SizedBox(height: 32),

                              /// USERNAME
                              Text("User Name",
                                  style: AppTextStyle.labelTextStyle),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: viewModel.usernameController,
                                validator: viewModel.validateUsername,
                                decoration: AppStyle.formFieldDecoration(
                                        context, "Enter")
                                    .copyWith(
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: context.colors.outline,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// PASSWORD
                              Text("Password",
                                  style: AppTextStyle.labelTextStyle),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: viewModel.passwordController,
                                validator: viewModel.validatePassword,
                                obscureText: viewModel.obscurePassword,
                                decoration: AppStyle.formFieldDecoration(
                                        context, "Enter")
                                    .copyWith(
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: context.colors.outline,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      viewModel.obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: context.colors.outline,
                                    ),
                                    onPressed:
                                        viewModel.togglePasswordVisibility,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              /// FORGOT PASSWORD
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: viewModel.onForgotPassword,
                                  child: Text(
                                    "Forgot Password ?",
                                    style: TextStyle(
                                      color: context.colors.onSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
