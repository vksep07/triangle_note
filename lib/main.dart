
import 'package:flutter/material.dart';
import 'package:plateron_assignment/app/app.dart';
import 'package:plateron_assignment/utils/common_widgets/custom_theme.dart';

void main() {
  runApp(const CustomTheme(
    initialThemeKey: MyThemeKeys.DARK,
    child: App(),
  ),);
}



