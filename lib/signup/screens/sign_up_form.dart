import 'package:flutter/material.dart';
import 'package:plateron_assignment/signup/widgets/auth_textfield.dart';
import 'package:plateron_assignment/signup/widgets/mobile_code_textfield.dart';
import 'package:plateron_assignment/utils/constants.dart';
import 'package:plateron_assignment/utils/extensions.dart';

class SignUpForm extends StatefulWidget {
  final Function numberTextChange;
  final Function nameTextChange;
  final Function pinTextChange;
  final Function reEnterPinTextChange;
  const SignUpForm({
    Key? key,
    required this.numberTextChange,
    required this.nameTextChange,
    required this.pinTextChange,
    required this.reEnterPinTextChange,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _reEnterPinController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.13),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            MobileWithCountryCodeTextfield(
              controller: _mobileNumberController,
              hintText: 'Enter mobile number',
              bgColor: loginBg,
              onTextChanged: (value) {
                widget.numberTextChange(value);
              },
            ),
            20.heightBox,
            AuthTextField(
              controller: _nameController,
              hintText: 'Enter name here',
              withContainer: true,
              bgColor: loginBg,
              keyboardType: TextInputType.text,
              onTextChanged: (value) {
                widget.nameTextChange(value);
              },
            ),
            20.heightBox,
            AuthTextField(
              controller: _pinController,
              hintText: 'Enter pin',
              withContainer: true,
              bgColor: loginBg,
              obscureText: true,
              onTextChanged: (value) {
                widget.pinTextChange(value);
              },
            ),
            20.heightBox,
            AuthTextField(
              controller: _reEnterPinController,
              hintText: 'Reenter pin',
              withContainer: true,
              bgColor: loginBg,
              obscureText: true,
              onTextChanged: (value) {
                widget.reEnterPinTextChange(value);
              },
            ),
            const Spacer(flex: 2)
          ],
        ),
      ),
    );
  }
}
