

import 'package:plateron_assignment/utils/common/routes/routes.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';

class SplashBloc {
  redirectToHomeScreen() {
    Future.delayed(const Duration(seconds: 3), () async {
     appNavigationService.pushReplacementNamed(Routes.auth_screen);
    });
  }
}

final splashBloc = SplashBloc();
