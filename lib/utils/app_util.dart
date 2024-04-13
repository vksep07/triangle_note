
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';

class AppUtil {
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String getTwoDigitsNumberAlways(String num) {
    if (num.length == 1) {
      return "0$num";
    }
    return num;
  }

  static BuildContext getBuildContext() {
    return appNavigationService.myNavigatorKey.currentState!.context;
  }

  static setStatusBarColor({Color? statusBarColor}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: statusBarColor));
  }


  static String formatCurrency(dynamic moneyCounter) {
    //TODO CHANGE TO INDIAN CURRENCY FORMAT

    if (moneyCounter.runtimeType == String) {
      moneyCounter = num.tryParse(moneyCounter);
    }

    // final formatCurrency = new NumberFormat.simpleCurrency();
    final formatCurrency = NumberFormat.currency(locale: "en_IN", symbol: "₹");

    // AppLogger.printLog("price for amount-----moneyCounter--------$moneyCounter----- ${formatCurrency.format(moneyCounter ?? 0)}");

    //REMOVE IF .00 COMES AFTER THAT
    return formatCurrency.format(moneyCounter ?? 0);
  }


  String formatTimestampToDateTime(int timestamp) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  return formattedDate;
}
}
