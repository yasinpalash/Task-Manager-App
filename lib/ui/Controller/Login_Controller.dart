import 'package:get/get.dart';

import '../../data/network-utils.dart';
import '../utils/auth-utils.dart';

class LoginController extends GetxController {
  bool _inProgress = false;

  bool get LoginInProgress => _inProgress;
  Future<bool> login(String email, String password) async {
    _inProgress = true;
    update();
    final result = await NetworkUtils().postMethod(
      'https://task.teamrabbil.com/api/v1/login',
      body: {
        'email': email,
        'password': password,
      },
    );
    _inProgress = false;
    update();
    if (result != null && result['status'] == 'success') {
      await AuthUtils.saveUserData(
        result['data']['firstName'],
        result['data']['lastName'],
        result['token'],
        result['data']['photo'],
        result['data']['mobile'],
        result['data']['email'],
      );
      return true;
    } else {}
    return false;
  }
}
