// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:triangle_note/app/app_config.dart';

class AppTextWidget extends StatelessWidget {
  String? text;
  double? size;
  FontWeight? fontWeight;
  Color? color;
  double? wordSpacing;
  VoidCallback? onClick;
  int? maxlines;
  TextAlign? textAlign;
  TextOverflow? overflow;

  AppTextWidget({
    super.key,
    @required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.wordSpacing,
    this.onClick,
    this.maxlines,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(
              text ?? "",
              textAlign: textAlign ?? TextAlign.center,
              overflow: overflow ?? TextOverflow.ellipsis,
              softWrap: true,
              maxLines: maxlines ?? 2,
              style: TextStyle(
                fontSize: size ?? appConfig.defaultTextSize,
                fontWeight: fontWeight ?? FontWeight.normal,
                color: color ?? Theme.of(context).primaryColorDark,
                wordSpacing: wordSpacing ?? appConfig.defaultWordspacing,
              ),
            )
          : TextButton(
              onPressed: () {
                onClick?.call();
              },
              child: Text(
                text ?? "",
                style: TextStyle(
                  fontSize: size ?? appConfig.defaultTextSize,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: color,
                  wordSpacing: wordSpacing ?? appConfig.defaultWordspacing,
                ),
              ),
            ),
    );
  }
}
