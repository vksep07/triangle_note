import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';

class AppUtil {
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static BuildContext getBuildContext() {
    return appNavigationService.myNavigatorKey.currentState!.context;
  }

  static setStatusBarColor({Color? statusBarColor}) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: statusBarColor));
  }

  String formatTimestampToDateTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    return formattedDate;
  }
}
