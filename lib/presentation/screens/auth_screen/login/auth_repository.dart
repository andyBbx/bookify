import 'dart:convert';

import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/service/place_service.dart';
import 'package:bookify/data/service/service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepository {
  Future<bool> login(user, password) async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var _token =  await messaging.getToken();
    print("token ${_token}");
    var data = {"email": user, "password": password , "token" : _token};
    bool isManager = false;
    await postService(data, '/user/login', "").then((value) async {
      if (value['code'] != 200) {
        var error = jsonDecode(value['message']);
        throw Exception(error['message']);
      } else {
        var userData = jsonDecode(value['model']);
        isManager = userData["is_manager"] ?? false;
        saveUserModel(value['model']);
        // await setLocation();

      }
    });
    return isManager;
  }
}
