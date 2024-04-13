// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:plateron_assignment/signup/screens/login_form.dart';
import 'package:plateron_assignment/signup/screens/sign_up_form.dart';
import 'package:plateron_assignment/signup/service/auth_service.dart';
import 'package:plateron_assignment/utils/app_snackbar.dart';
import 'package:plateron_assignment/utils/common/routes/routes.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';
import 'package:plateron_assignment/utils/constants.dart';
import 'package:plateron_assignment/utils/extensions.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;
  AuthService service = GetIt.I<AuthService>();

  String loginMobileNumber = '';
  String loginPin = '';
  String? name;
  String? mobileNumber;
  String? pin;
  String? reEnterPin;

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Stack(
                children: [
                  // login screen
                  AnimatedPositioned(
                    duration: defaultDuration,
                    width: width * 0.88,
                    height: height,
                    left: _isShowSignUp ? -width * 0.76 : 0,
                    child: Container(
                      color: loginBg,
                      child: LoginForm(
                        numberTextChange: (value) {
                          loginMobileNumber = value;
                        },
                        pinTextChange: (value) {
                          loginPin = value;
                        },
                      ),
                    ),
                  ),

                  // signUp screen
                  AnimatedPositioned(
                    duration: defaultDuration,
                    left: _isShowSignUp ? width * 0.12 : width * 0.88,
                    width: width * 0.88,
                    height: height,
                    child: Container(
                      color: signUpBg,
                      child: SignUpForm(
                        nameTextChange: (value) {
                          name = value;
                        },
                        numberTextChange: (value) {
                          mobileNumber = value;
                        },
                        pinTextChange: (value) {
                          pin = value;
                        },
                        reEnterPinTextChange: (value) {
                          reEnterPin = value;
                        },
                      ),
                    ),
                  ),

                  // logo
                  AnimatedPositioned(
                    // left: 0,
                    duration: defaultDuration,
                    width: width,
                    right: _isShowSignUp ? -width * 0.06 : width * 0.06,
                    top: context.height * 0.1, // 10%
                    child: CircleAvatar(
                      backgroundColor: _isShowSignUp
                          ? Colors.white60
                          : signUpBg.withOpacity(0.5),
                      radius: 40,
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: SvgPicture.asset(
                            'assets/images/animation_logo.svg',
                            color: _isShowSignUp ? signUpBg : loginBg),
                      ),
                    ),
                  ),

                  // social media
                  // AnimatedPositioned(
                  //   duration: defaultDuration,
                  //   // left: 0,
                  //   width: width,
                  //   right: _isShowSignUp ? -width * 0.06 : width * 0.06,
                  //   bottom: context.height * 0.1, // 10%
                  //   child: const SocialButtons(),
                  // ),

                  //login text animation
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: _isShowSignUp
                        ? context.height / 2 - 80
                        : context.height * 0.4, //30%
                    left: _isShowSignUp
                        ? 0
                        : width * 0.44 - 80, // container width is 160 / 2 = 80
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isShowSignUp ? Colors.white : Colors.white70,
                        fontSize: _isShowSignUp ? 20 : 25,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Transform.rotate(
                        angle: -_animationTextRotate.value * pi / 180,
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            if (_isShowSignUp) {
                              updateView();
                            } else {
                              service.userLogin(
                                mobileNumber: loginMobileNumber,
                                pin: loginPin,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: (_isShowSignUp)
                                    ? Colors.transparent
                                    : Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 160,
                            child: const Text(
                              'LOG IN',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //signUp text animation
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: !_isShowSignUp
                        ? context.height / 2 - 80
                        : context.height * 0.32, //30%
                    right: _isShowSignUp
                        ? width * 0.44 - 80
                        : 0, // width container is 160 / 2 = 80
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isShowSignUp ? loginBg : loginBg,
                        fontSize: !_isShowSignUp ? 20 : 27,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Transform.rotate(
                        angle: (90 - _animationTextRotate.value) * pi / 180,
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            if (!_isShowSignUp) {
                              updateView();
                            } else {
                              // SignUp screen appear
                              service.userSignup(
                                name: name,
                                mobileNumber: mobileNumber,
                                pin: pin,
                                reEnterPin: reEnterPin,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.75),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: (_isShowSignUp)
                                    ? loginBg
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 160,
                            child: const Text(
                              'SIGN UP',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }));
  }
}
