import 'package:flutter/foundation.dart';
import 'env_config.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig instance = AppConfig._();

  late final AppEnvironment environment;
  late final EnvConfig config;

  Future<void> initialize() async {
    environment = AppEnvironment.fromDefine();

    config = switch (environment) {
      AppEnvironment.dev => EnvConfig.dev(),
      AppEnvironment.uat => EnvConfig.uat(),
      AppEnvironment.prod => EnvConfig.prod(),
    };

    debugPrint('🌍 Environment: ${environment.name}');
    debugPrint('🔗 Base URL: ${config.baseUrl}');
  }

  /// Common getters
  String get baseUrl => config.baseUrl;
  String get apiVersion => config.apiVersion;
  int get timeout => config.timeout;
  String get appName => config.appName;
}
