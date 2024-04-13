// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plateron_assignment/notes/models/notes_data_model.dart';
import 'package:plateron_assignment/notes/screens/add_note_screen.dart';
import 'package:plateron_assignment/notes/screens/notes_screen.dart';
import 'package:plateron_assignment/notes/service/note_service.dart';
import 'package:plateron_assignment/signup/screens/auth_screen.dart';
import 'package:plateron_assignment/signup/service/auth_service.dart';
import 'package:plateron_assignment/splash_screen/view/splash_screen.dart';

class Routes {
  static const String splash = 'splash';
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
    GetIt.I.registerSingleton<NoteService>(NoteService());
  }
}
