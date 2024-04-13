import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:plateron_assignment/utils/constants.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool withContainer;
  final Color? bgColor;
  final Function? onTextChanged;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.withContainer = false,
    this.bgColor,
    this.maxLength,
    this.onTextChanged,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return (withContainer)
        ? Container(
            height: 50,
            decoration: BoxDecoration(
              color: bgColor ?? signUpBg.withOpacity(0.5),
              border: Border.all(width: 0, color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: getTextField(
              controller: controller,
              hintText: hintText,
              context: context
            ),
          )
        : getTextField(
            controller: controller,
            hintText: hintText,
            context: context,
          );
  }

  Widget getTextField({
    String? hintText,
    required TextEditingController? controller,
   required BuildContext context,
  }) {
    return TextField(
      cursorColor: Theme.of(context).primaryColorLight,
      obscureText: obscureText ?? false,
      controller: controller,
      style:  TextStyle(color: Theme.of(context).primaryColorLight),
      maxLength: maxLength ?? 10,
      keyboardType: keyboardType ?? TextInputType.number,
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        hintStyle:  TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        // Remove the border outline
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(10),
      ),
      onChanged: (value) {
        if (onTextChanged != null) {
          onTextChanged!(value);
        }
      },
    );
  }
}
