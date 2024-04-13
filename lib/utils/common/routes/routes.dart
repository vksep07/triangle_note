// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plateron_assignment/home/bloc/home_bloc.dart';
import 'package:plateron_assignment/home/view/cart_screen.dart';
import 'package:plateron_assignment/home/view/home_screen.dart';
import 'package:plateron_assignment/home/view/order_success_screen.dart';
import 'package:plateron_assignment/notes/models/notes_data_model.dart';
import 'package:plateron_assignment/notes/screens/add_note_screen.dart';
import 'package:plateron_assignment/notes/screens/notes_screen.dart';
import 'package:plateron_assignment/notes/service/note_service.dart';
import 'package:plateron_assignment/signup/screens/auth_screen.dart';
import 'package:plateron_assignment/signup/screens/login_screen.dart';
import 'package:plateron_assignment/signup/service/auth_service.dart';
import 'package:plateron_assignment/splash_screen/view/splash_screen.dart';

class Routes {
  static const String home_screen = 'home_Screen';
  static const String splash = 'splash';
  static const String cart_screen = 'cart_screen';
  static const String order_success_screen = 'order_success_screen';
  static const String login_screen = 'login_screen';
  static const String add_note_screen = 'add_note_screen';
  static const String note_screen = 'note_screen';
  static const String auth_screen = 'auth_screen';

  static Route<dynamic>? getGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: splash),
          builder: (_) => const SplashScreen(),
        );

      case home_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: home_screen),
          builder: (_) => HomeScreen(),
        );

      case cart_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: cart_screen),
          builder: (_) => CartScreen(),
        );

      case order_success_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: order_success_screen),
          builder: (_) => OrderSuccessScreen(),
        );

      case login_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: order_success_screen),
          builder: (_) => const LoginScreen(),
        );

      case add_note_screen:
        NoteDataModel? args;
        if (settings.arguments != null) {
          args = settings.arguments as NoteDataModel;
        }
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: add_note_screen),
          builder: (_) => EditNotePage(
            existingNote: args,
          ),
        );

      case note_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: note_screen),
          builder: (_) => const NoteScreen(),
        );

        case auth_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: auth_screen),
          builder: (_) => const AuthScreen(),
        );

      default:
        return null;
    }
  }

  static void setupGetIt() {
     GetIt.I.registerSingleton<AuthService>(AuthService());
    GetIt.I.registerSingleton<HomeScreenBloc>(HomeScreenBloc());
    GetIt.I.registerSingleton<NoteService>(NoteService());
  }
}
