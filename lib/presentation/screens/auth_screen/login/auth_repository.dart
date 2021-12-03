import 'dart:convert';

import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/service/place_service.dart';
import 'package:bookify/data/service/service.dart';
import 'package:geolocator/geolocator.dart';

class AuthRepository {
  Future<bool> login(user, password) async {
    var data = {"email": user, "password": password};
    bool isManager = false;
    await postService(data, '/user/login', "").then((value) async {
      if (value['code'] != 200) {
        var error = jsonDecode(value['message']);
        throw Exception(error['message']);
      } else {
        Geolocator.requestPermission();

        await setLocation();
        saveUserModel(value['model']);
        // await setLocation();
        var userData = jsonDecode(value['model']);
        isManager = userData["is_manager"] ?? false;
      }
    });
    return isManager;
  }
}
