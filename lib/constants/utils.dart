import 'dart:convert';

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
