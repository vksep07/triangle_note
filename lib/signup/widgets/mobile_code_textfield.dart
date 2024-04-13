import 'package:flutter/material.dart';
import 'package:plateron_assignment/signup/widgets/auth_textfield.dart';
import 'package:plateron_assignment/utils/constants.dart';

class MobileWithCountryCodeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final Color? bgColor;
  final String? hintText;
  final Function? onTextChanged;
  const MobileWithCountryCodeTextfield({
    super.key,
    required this.controller,
    this.bgColor,
    this.hintText,
    this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: bgColor ?? signUpBg.withOpacity(0.5),
        border: Border.all(width: 0, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 40,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              readOnly: true,
              controller: TextEditingController(text: "+91"),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const Text(
            "|",
            style: TextStyle(
              fontSize: 33,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: AuthTextField(
              controller: controller,
              hintText: hintText ?? '',
              withContainer: false,
              onTextChanged: (value) {
                if (onTextChanged != null) {
                  onTextChanged!(value);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
