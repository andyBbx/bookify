import 'dart:convert';

import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/service/place_service.dart';
import 'package:bookify/data/service/service.dart';
import 'package:geolocator/geolocator.dart';

class AuthRepository {
  Future<void> login(user, password) async {
    var data = {"email": user, "password": password};
    await postService(data, '/user/login', "").then((value) async {
      if (value['code'] != 200) {
        print("Situation");
        var error = jsonDecode(value['message']);
        throw Exception(error['message']);
      } else {
        Geolocator.requestPermission();

        await setLocation();
        saveUserModel(value['model']);
        // await setLocation();
      }
    });
  }
}
