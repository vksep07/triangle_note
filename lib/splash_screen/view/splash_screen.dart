// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:plateron_assignment/splash_screen/bloc/splash_bloc.dart';
import 'package:plateron_assignment/utils/assets.dart';
import 'package:plateron_assignment/utils/common/logger/app_logger.dart';

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
                  child: Image.asset(
                    Assets.appLogo,
                    fit: BoxFit.contain,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
