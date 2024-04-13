// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:triangle_note/splash_screen/bloc/splash_bloc.dart';
import 'package:triangle_note/utils/assets.dart';
import 'package:triangle_note/utils/common/logger/app_logger.dart';
import 'package:triangle_note/utils/common_util/utils_importer.dart';
import 'package:triangle_note/utils/common_widgets/app_text_widget.dart';
import 'package:triangle_note/utils/spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    AppLogger.printLog("open splash screen");
    super.initState();
    splashBloc.redirectToHomeScreen();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: FadeTransition(
                opacity: animationController
                    .drive(CurveTween(curve: Curves.easeOut)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(
                    Assets.appLogo,
                    fit: BoxFit.contain,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ),
            AppTextWidget(
              text: UtilsImporter().stringUtils.appName,
              size: AppSpacing.xxxxl,
              fontWeight: FontWeight.bold,
            ),
          ],
        ));
  }
}
