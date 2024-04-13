import 'package:flutter/material.dart';
import 'package:triangle_note/signup/widgets/auth_textfield.dart';
import 'package:triangle_note/signup/widgets/mobile_code_textfield.dart';
import 'package:triangle_note/utils/common_util/string_utils.dart';
import 'package:triangle_note/utils/common_util/utils_importer.dart';
import 'package:triangle_note/utils/common_widgets/app_text_widget.dart';
import 'package:triangle_note/utils/constants.dart';
import 'package:triangle_note/utils/extensions.dart';

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
              bgColor: Theme.of(context).primaryColorDark,
              controller: _numberController,
              hintText: getStringObject().enter_mobile_number,
              onTextChanged: (value) {
                widget.numberTextChange(value);
              },
            ),
            20.heightBox,
            AuthTextField(
              controller: _pinController,
              hintText: getStringObject().enter_pin,
              maxLength: 4,
              withContainer: true,
              obscureText: true,
              bgColor: Theme.of(context).primaryColorDark,
              onTextChanged: (value) {
                widget.pinTextChange(value);
              },
            ),
            TextButton(
              onPressed: () {},
              child: AppTextWidget(
                size: 16,
                fontWeight: FontWeight.w500,
                text: getStringObject().forgot_pin,
                color: Theme.of(context).primaryColorDark,
              ),
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

  StringUtils getStringObject() {
    return UtilsImporter().stringUtils;
  }
}
