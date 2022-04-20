import 'dart:convert';

import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/owned_restaurant.dart';
import 'package:bookify/data/service/place_service.dart';
import 'package:bookify/data/service/service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepository {
  Future<bool> login(user, password) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var _token = await messaging.getToken();
    print("FCMtoken ${_token}");
    var data = {"email": user, "password": password, "token": _token};
    bool isManager = false;
    await postService(data, '/user/login', "").then((value) async {
      if (value['code'] != 200) {
        var error = jsonDecode(value['message']);
        throw Exception(error['message']);
      } else {
        var userData = jsonDecode(value['model']);
        isManager = userData["is_manager"] ?? false;
        saveUserModel(value['model']);
        if (isManager) {
          var response = await getService('/user/manager-restaurants', '');
          if (response['code'] == 200) {
            var jsonRest = jsonDecode(response['model']);
            List<OwnedRestaurantModel> ownedRestaurants = [];

            for (var i = 0; i < jsonRest.length; i++) {
              ownedRestaurants.add(OwnedRestaurantModel.fromJson(jsonRest[i]));
            }

            //Let's check if there is any restaurant set as default, if not, we take the first one
            if (jsonRest.length == 1) {
              Utils().startSharedPreferences().then((prefs) {
                prefs.setString(
                    "current_restaurant", jsonEncode(ownedRestaurants.first));
              });
            }
          }
        }
        // await setLocation();
      }
    });
    return isManager;
  }
}
