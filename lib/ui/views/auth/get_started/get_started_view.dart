import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/colors.dart';
import 'package:gericare_doctor/core/res/images.dart';
import 'package:stacked/stacked.dart';
import 'get_started_view_model.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GetStartedViewModel>.reactive(
      viewModelBuilder: () => GetStartedViewModel(),
      builder: (context, viewModel, _) {
        return Scaffold(
          // backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  /// LOGO
                  Image.asset(
                    Images.appLogo,
                    height: 48,
                  ),

                  SizedBox(
                    height: 36,
                  ),

                  /// HERO IMAGE
                  Expanded(
                      child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          Images.getStarted,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text(
                        "Kickstart Your Shift\nwith Ease",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            color: AppColor.primary),
                      ),

                      /// TITLE

                      const SizedBox(height: 24),

                      /// SUBTITLE
                      const Text(
                        "Everything you need – tasks, alerts, and patient info – all in one simple, real-time view.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.black,
                          height: 1.5,
                        ),
                      ),
                    ],
                  )),

                  const SizedBox(height: 32),

                  /// CTA BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onPressed: viewModel.onGetStarted,
                      child: const Text(
                        "Get started",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
