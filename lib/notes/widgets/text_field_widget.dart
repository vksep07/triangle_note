import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function? onFieldSubmitted;
  final Function? onChanged;
  final FocusNode? titleFocus;
  final String? hintText;
  final FontWeight? fontWeight;
  final double? fontSize;

  const TextFieldWidget({
    super.key,
    required this.textEditingController,
    this.onFieldSubmitted,
    this.onChanged,
    this.titleFocus,
    this.hintText,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: titleFocus,
      autofocus: true,
      controller: textEditingController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onFieldSubmitted: (text) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted!(text);
        }
      },
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      textInputAction: TextInputAction.next,
      style: TextStyle(
        fontSize: fontSize ?? 32,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: fontSize ?? 32,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }
}
