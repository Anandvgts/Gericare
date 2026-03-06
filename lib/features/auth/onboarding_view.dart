import 'package:doctor/core/constants/app_sizes.dart';
import 'package:doctor/core/constants/images.dart';
import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:doctor/features/widgets/app_logo_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              /// LOGO
              gapH16,
              const AppLogoHeader(),

              /// MAIN CONTENT
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.getStarted,
                      height: 380.h,
                      fit: BoxFit.contain,
                    ),
                    gapH24,
                    Text(
                      'Kickstart Your Shift\nwith Ease',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.heading24.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    gapH12,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        'Everything you need — tasks, alerts, and patient info all in one simple, real-time view.',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodyText1SubText.copyWith(
                          color: AppColor.black,
                          fontSize: 14.h,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// CTA BUTTON (BOTTOM)
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () async {
                    await preferenceService.setSeenOnboarding();
                    navigationService.pushNamed(Routes.login);
                  },
                  child: Text('Get started', style: AppTextStyle.button),
                ),
              ),

              gapH24,
            ],
          ),
        ),
      ),
    );
  }
}
