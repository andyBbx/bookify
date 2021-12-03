import 'dart:convert';

import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/service/service.dart';

class AuthRepository {
  Future<bool> login(user, password) async {
    var data = {"email": user, "password": password};
    bool isManager = false;
    await postService(data, '/user/login', "").then((value) {
      if (value['code'] != 200) {
        var error = jsonDecode(value['message']);
        throw Exception(error['message']);
      } else {
        saveUserModel(value['model']);
        var userData = jsonDecode(value['model']);
        isManager = userData["is_manager"] ?? false;
      }
    });
    return isManager;
  }
}
