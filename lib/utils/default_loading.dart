import 'package:flutter/material.dart';
import 'package:plateron_assignment/utils/assets.dart';
import 'package:plateron_assignment/utils/common_util/utils_importer.dart';

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                backgroundColor: UtilsImporter().colorUtils.primarycolor,
                valueColor: AlwaysStoppedAnimation<Color>(UtilsImporter().colorUtils.greycolor),
              ),
            ),
          ),
          Center(
            child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  Assets.appLogo,
                  fit: BoxFit.contain,
                  color: UtilsImporter().colorUtils.primarycolor.withOpacity(0.9),
                )),
          ),
        ],
      )),
    );
  }
}
