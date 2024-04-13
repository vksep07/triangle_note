import 'package:plateron_assignment/utils/common/routes/routes.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';
import 'package:plateron_assignment/utils/common/services/shared_preference_service.dart';

class SplashBloc {
  redirectToHomeScreen() {
    Future.delayed(const Duration(seconds: 3), () async {
      bool isAlreadyLogin = await sharedPreferenceService.getLoginStatus();
      if (isAlreadyLogin) {
        appNavigationService.pushReplacementNamed(Routes.note_screen);
      } else {
        appNavigationService.pushReplacementNamed(Routes.auth_screen);
      }
    });
  }
}

final splashBloc = SplashBloc();
