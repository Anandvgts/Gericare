import 'package:doctor/core/constants/images.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final seenOnboarding = preferenceService.hasSeenOnboarding;
    final loggedIn = sessionService.isLoggedIn;
    final validSession = await sessionService.validateSession();

    await Future.delayed(const Duration(seconds: 2));

    if (!seenOnboarding) {
      navigationService.popAllAndPushNamed(Routes.getStarted);
      return;
    }

    if (!loggedIn) {
      navigationService.popAllAndPushNamed(Routes.login);
      return;
    }

    if (!validSession) {
      navigationService.popAllAndPushNamed(Routes.login);
      return;
    }

    navigationService.popAllAndPushNamed(Routes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Center(
        child: Image.asset(
          Images.splashLogo,
          width: 200.w,
          height: 120.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
