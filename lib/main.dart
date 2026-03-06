import 'dart:async';

import 'package:doctor/bootstrap.dart';
import 'package:doctor/core/styles/theme.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:doctor/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    await Bootstrap().configure();
  }, (error, stack) {
    Logger.e('Zoned Error', e: error, s: stack);
  });
}

class MyApp extends StatelessWidget {
  // final String initialRoute;
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone base
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          title: 'GeriCare Doctor',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: snackBarService.scaffoldMessengerKey,
          theme: AppStyle.appTheme,
          navigatorKey: navigationService.navigatorKey,
          initialRoute: Routes.splash,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
