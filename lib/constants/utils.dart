import 'dart:convert';

import 'package:bookify/data/models/location.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/place_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  late SharedPreferences prefs;

  Future startSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  checkJsonArray(data) {
    if (data == null) {
      return false;
    }
    var jsonString = data;
    var decodeSucceeded = false;

    try {
      var array = jsonDecode(jsonString);
      if (array != "" && array != null) {
        decodeSucceeded = true;
      }
    } on FormatException catch (e) {
      print('The provided string is not valid JSON');
    }

    //print('Decoding succeeded: $decodeSucceeded');

    return decodeSucceeded;
  }
}

late SharedPreferences prefs;

Future startSharedPreferences() async {
  prefs = await SharedPreferences.getInstance();
}

saveUserModel(dynamic data) async {
  await startSharedPreferences().then((value) {
    prefs.setString("user", data);
    String? userModelString = prefs.getString("user");
    if (Utils().checkJsonArray(userModelString)) {
      User newuser = User();
      newuser = newuser.fromJson(jsonDecode(userModelString!));
    }
  });
}

saveUserUbi(String data) async {
  await startSharedPreferences().then((value) {
    prefs.setString("location", data);
  });
}

Widget logo(widht) {
  return SvgPicture.asset(
    "assets/logo.svg",
    width: widht / 3,
  );
}

Iterable<TimeOfDay> getTimeSlots(
    TimeOfDay startTime, TimeOfDay endTime, Duration interval) sync* {
  var hour = startTime.hour;
  var minute = startTime.minute;

  do {
    yield TimeOfDay(hour: hour, minute: minute);
    minute += interval.inMinutes;
    while (minute >= 60) {
      minute -= 60;
      hour++;
    }
  } while (hour < endTime.hour ||
      (hour == endTime.hour && minute <= endTime.minute));
}

void launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

setLocation() async {
  await Geolocator.requestPermission();

  await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true)
      .then((Position position) async {
    if (position != null) {
      var place = await PlaceApiProvider('12345')
          .getPlaceFromGeo(position.latitude, position.longitude);
      saveUserUbi(
          '{"adresss": "${place.adresss}", "long": "${place.long}", "lat": "${place.lat}"}');
    } else {
      await prefs.setString("location", "");
    }
  }).catchError((e) {
    print(e);
  });
}
