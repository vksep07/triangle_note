import 'package:plateron_assignment/signup/model/user_model.dart';
import 'package:plateron_assignment/utils/app_toast.dart';
import 'package:plateron_assignment/utils/common/local_storage/database_helper.dart';
import 'package:plateron_assignment/utils/common/routes/routes.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';
import 'package:plateron_assignment/utils/common/services/shared_preference_service.dart';

class AuthService {
  Future<bool> loginUser({
    required String mobileNumber,
    required String pin,
  }) async {
    bool isAuthorised =
        await userAuthoriseOrNot(mobileNumber: mobileNumber, pin: pin);
    if (isAuthorised) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> userAuthoriseOrNot(
      {required String mobileNumber, required String pin}) async {
    UserModel user = await getUserModel(mobileNumber: mobileNumber);
    if (user.pin == pin) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> getUserModel({required String mobileNumber}) async {
    Map<String, dynamic>? userMap =
        await DatabaseHelper().getUser(mobileNumber: mobileNumber);
    UserModel user = UserModel(
      mobileNumber: userMap!['mobileNumber'],
      name: userMap['name'],
      pin: userMap['pin'],
    );
    return user;
  }

  Future<bool> checkUserExist({required String mobileNumber}) {
    return DatabaseHelper().doesUserExist(mobileNumber);
  }

  // Future<bool> addUser({
  //   required String mobileNumber,
  //   required String name,
  //   required String pin,
  // }) async {
  //   bool isExist = await checkUserExist(mobileNumber: mobileNumber);
  //   if (!isExist) {
  //     await DatabaseHelper().addUser(
  //       mobileNumber: mobileNumber,
  //       name: name,
  //       pin: pin,
  //     );
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> userLogin({
    String? mobileNumber,
    String? pin,
  }) async {
    if (mobileNumber == null) {
      _showToast('Please fill the mobile number');
      return;
    } else if (mobileNumber.length < 10) {
      _showToast('Please enter the valid mobile number');
      return;
    } else if (pin == null) {
      _showToast('Please fill the pin');
      return;
    } else if (pin.length < 4) {
      _showToast('Please enter the valid pin');
      return;
    } else {
      bool isExist = await checkUserExist(mobileNumber: mobileNumber);
      if (!isExist) {
        _showToast('User does not exist. Please sign up');
        return;
      } else {
        bool isSuccess = await loginUser(
          mobileNumber: mobileNumber,
          pin: pin,
        );
        
        if (isSuccess) {
          sharedPreferenceService.setLoginStatus(isLogin: true);
          appNavigationService.pushReplacementNamed(Routes.note_screen);
        } else {
          _showToast('Invalid credentials');
        }
      }
    }
  }

  Future<void> userSignup({
    String? mobileNumber,
    String? name,
    String? pin,
    String? reEnterPin,
  }) async {
    if (mobileNumber == null) {
      _showToast('Please fill the mobile number');
      return;
    } else if (mobileNumber.length < 10) {
      _showToast('Please enter the valid mobile number');
      return;
    }
    if (name == null) {
      _showToast('Please fill the name');
      return;
    } else if (name.isEmpty) {
      _showToast('Please enter the valid name');
      return;
    } else if (pin == null) {
      _showToast('Please fill the pin');
      return;
    } else if (pin.length < 4) {
      _showToast('Please enter the valid pin');
      return;
    } else if (reEnterPin == null) {
      _showToast('Please fill the pin');
      return;
    } else if (reEnterPin.length < 4) {
      _showToast('Please enter the valid pin');
      return;
    } else if (reEnterPin != pin) {
      _showToast('Pin & RePin does not match');
      return;
    } else {
      bool isExist = await checkUserExist(mobileNumber: mobileNumber);
      if (isExist) {
        _showToast('User already exist. Please login');
        return;
      } else {
      int value=  await DatabaseHelper().addUser(
          mobileNumber: mobileNumber,
          name: name,
          pin: pin,
        );
        if (value==1) {
          appNavigationService.pushReplacementNamed(Routes.note_screen);
        } else {
          _showToast('Something went wrong');
        }
      }
    }
  }

  void _showToast(String message) {
    showToast(message: message);
  }
}
