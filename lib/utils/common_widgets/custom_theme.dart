// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:plateron_assignment/utils/common_util/utils_importer.dart';

enum MyThemeKeys { LIGHT, DARK, DARKER }

class MyThemes {
  static String? LIGHT = 'LIGHT';
  static String? DARK = 'DARK';
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.grey[850],
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: UtilsImporter().colorUtils.primarycolor,
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey[850],
    primaryColorLight: Colors.grey[850],
    primaryColorDark: Colors.white,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: UtilsImporter().colorUtils.primarycolor,
        ),
      ),
    ),
  );

  static final ThemeData darkerTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      case MyThemeKeys.DARKER:
        return darkerTheme;
      default:
        return lightTheme;
    }
  }
}

class _CustomTheme extends InheritedWidget {
  final CustomThemeState? data;

  _CustomTheme({
    this.data,
    Key? key,
    @required Widget? child,
  }) : super(key: key, child: child!);

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

class CustomTheme extends StatefulWidget {
  final Widget? child;
  final MyThemeKeys? initialThemeKey;

  const CustomTheme({
    Key? key,
    this.initialThemeKey,
    @required this.child,
  }) : super(key: key);

  @override
  CustomThemeState createState() => CustomThemeState();

  static ThemeData of(BuildContext? context) {
    _CustomTheme inherited = (context
        ?.dependOnInheritedWidgetOfExactType<_CustomTheme>() as _CustomTheme);
    return inherited.data!.theme!;
  }

  static CustomThemeState instanceOf(BuildContext? context) {
    _CustomTheme inherited = (context
        ?.dependOnInheritedWidgetOfExactType<_CustomTheme>() as _CustomTheme);
    return inherited.data!;
  }
}

class CustomThemeState extends State<CustomTheme> {
  ThemeData? _theme;

  ThemeData? get theme => _theme;

  @override
  void initState() {
    _theme = MyThemes.getThemeFromKey(widget.initialThemeKey!);
    super.initState();
  }

  void changeTheme(MyThemeKeys themeKey) {
    setState(() {
      _theme = MyThemes.getThemeFromKey(themeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTheme(
      data: this,
      child: widget.child,
    );
  }
}
