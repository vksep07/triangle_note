
import 'package:flutter/material.dart';
import 'package:triangle_note/app/app.dart';
import 'package:triangle_note/utils/common_widgets/custom_theme.dart';

void main() {
  runApp(const CustomTheme(
    initialThemeKey: MyThemeKeys.LIGHT,
    child: App(),
  ),);
}



