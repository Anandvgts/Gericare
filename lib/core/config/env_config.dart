enum AppEnvironment {
  dev,
  uat,
  prod;

  bool get isDev => this == AppEnvironment.dev;
  bool get isUat => this == AppEnvironment.uat;
  bool get isProd => this == AppEnvironment.prod;

  String get name => switch (this) {
        AppEnvironment.dev => 'DEV',
        AppEnvironment.uat => 'UAT',
        AppEnvironment.prod => 'PROD',
      };

  static AppEnvironment fromDefine() {
    const env = String.fromEnvironment(
      'ENV',
      defaultValue: 'dev',
    );

    switch (env.toLowerCase()) {
      case 'prod':
        return AppEnvironment.prod;
      case 'uat':
        return AppEnvironment.uat;
      default:
        return AppEnvironment.dev;
    }
  }
}



class EnvConfig {
  final String baseUrl;
  final String apiVersion;
  final int timeout;
  final String appName;

  const EnvConfig({
    required this.baseUrl,
    required this.apiVersion,
    required this.appName,
    this.timeout = 30000,
  });

  factory EnvConfig.dev() {
    return const EnvConfig(
      baseUrl: 'https://dev.api.gericare.techdemo.in',
      apiVersion: 'v1',
      appName: 'Gericare (DEV)',
    );
  }

  factory EnvConfig.uat() {
    return const EnvConfig(
      baseUrl: 'https://uat.api.example.com',
      apiVersion: 'v1',
      appName: 'Gericare (UAT)',
    );
  }

  factory EnvConfig.prod() {
    return const EnvConfig(
      baseUrl: 'https://api.example.com',
      apiVersion: 'v1',
      appName: 'Gericare',
    );
  }
}
