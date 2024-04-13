import 'dart:developer';

class AppLogger {
  static bool logEnable = true;

  static void printLog(
    Object object, {
    String? tag,
  }) {
    if (logEnable) {
      log('[ ${tag ?? 'log'} ] ${object.toString()}');
    }
  }
}
