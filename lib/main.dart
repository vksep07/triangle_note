import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:plateron_assignment/app/app.dart';
import 'package:plateron_assignment/utils/common_widgets/custom_theme.dart';

void main() {
  runApp(CustomTheme(
    initialThemeKey: MyThemeKeys.LIGHT,
    child: App(),
  ),);
}



