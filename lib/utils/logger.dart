
import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';

enum LogLevel { debug, warning, error }

class Logger {
  static final _clients = <LoggerClient>[];

  /// Debug level logs
  static d(String message, {dynamic e, StackTrace? s}) {
    _clients.forEach((c) => c.onLog(
          level: LogLevel.debug,
          message: message,
          e: e,
          s: s,
        ));

    loggerService.log(LogLevel.debug.name, message, DateTime.now().toString());
  }

  // Warning level logs
  static w(
    String message, {
    dynamic e,
    StackTrace? s,
  }) {
    _clients.forEach((c) => c.onLog(
          level: LogLevel.warning,
          message: message,
          e: e,
          s: s,
        ));

    loggerService.log(LogLevel.warning.name, message, DateTime.now().toString());
  }

  /// Error level logs
  /// Requires a current StackTrace to report correctly on Crashlytics
  /// Always reports as non-fatal to Crashlytics
  static e(String message, {dynamic e, required StackTrace s}) {
    _clients.forEach((c) => c.onLog(
          level: LogLevel.error,
          message: message,
          e: e,
          s: s,
        ));

    loggerService.log(LogLevel.error.name, message, DateTime.now().toString());
  }

  static addClient(LoggerClient client) {
    _clients.add(client);
  }
}

abstract class LoggerClient {
  onLog({
    required LogLevel level,
    required String message,
    required dynamic e,
    StackTrace? s,
  });
}

class LogService {
  final List<LogServiceParam> _logHistory = [];

  List<LogServiceParam> get logHistory => _logHistory;

  log(String type, String message, String time) {
    _logHistory.insert(0, LogServiceParam(type, message, time));
  }

  clear() {
    _logHistory.clear();
  }
}


class LogServiceParam {
  String type;
  String message;
  String time;
  bool expanded = false;

  Color get color {
    print(type);

    switch (type) {
      case "[DEBUG]":
        return Colors.blue;
      case "[WARNING]":
        return Colors.yellow;
      case "[ERROR]":
        return Colors.red;
      default:
        return AppColor.textOnPrimary;
    }
  }

  LogServiceParam(this.type, this.message, this.time);
}
