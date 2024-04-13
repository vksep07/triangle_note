import 'package:flutter/material.dart';
import 'package:plateron_assignment/signup/widgets/auth_textfield.dart';
import 'package:plateron_assignment/signup/widgets/mobile_code_textfield.dart';
import 'package:plateron_assignment/utils/constants.dart';
import 'package:plateron_assignment/utils/extensions.dart';

class LoginForm extends StatefulWidget {
  final Function numberTextChange;
  final Function pinTextChange;
  const LoginForm({
    Key? key,
    required this.numberTextChange,
    required this.pinTextChange,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              controller: _numberController,
              hintText: 'Enter mobile number',
              onTextChanged: (value){
                widget.numberTextChange(value);
              },
            ),
            20.heightBox,
            AuthTextField(
              controller: _pinController,
              hintText: 'Enter pin',
              maxLength: 4,
              withContainer: true,
              obscureText: true,
              onTextChanged: (value) {
                widget.pinTextChange(value);
              },
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Forgot Pin?",
                  style: TextStyle(color: Colors.white)),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder getborder() {
    Color color = signUpBg.withOpacity(0.5);
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 0),
      borderRadius: BorderRadius.circular(5.0),
    );
  }
}
