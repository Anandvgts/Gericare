import 'dart:async';
import 'dart:ui';
import 'package:doctor/core/config/app_config.dart';
import 'package:doctor/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'locator.dart';
import 'main.dart';
import 'utils/logger.dart';

class Bootstrap {
  Future<void> configure() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppConfig.instance.initialize();

    _setupErrorHandling();
    await _initializeServices();

    await _setupSystemUI();

    // final initialRoute = await _getInitialRoute();

    runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );
  }

 

  Future<void> _setupSystemUI() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _setupErrorHandling() {
    FlutterError.onError = (details) {
      Logger.e(
        'Flutter Error',
        e: details.exception,
        s: details.stack!,
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      Logger.e('Platform Error', e: error, s: stack);
      return true;
    };
  }

  Future<void> _initializeServices() async {
    debugPrint('🛠️  Initializing services...');

    try {
      networkService.init();
      // API Service (HTTP client)
      apiBaseService.init();
      await preferenceService.init();

      debugPrint('✅ Services initialized');
    } catch (e, stackTrace) {
      debugPrint('❌ Services initialization error: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }
}
