import 'dart:convert';

import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/user.dart';
import 'package:http/http.dart' as http;

String urlApi = "https://api.reservas.androidtemplates.es/v1";

Future<Map<String, dynamic>> postService(
    dynamic data, String url, String token) async {
  var finalResponse;

  User user = User();
  String authToken = "";

  try {
    await Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));
        if ((user.id)!.isEmpty) {
          //logout;
        } else {
          authToken = user.auth_key!;
        }
      }
    });

    final http.Response response = await http.post(Uri.parse("$urlApi$url"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
        /* body: jsonEncode({
            "firstname": userr.name,
            "middlename": userr.firstLastname,
            "lastname": userr.secondLastName,
            "email": userr.email,
            "password": userr.password,
            "is_manager": userr.isManager
          }) */
        body: jsonEncode(data));
    print(jsonEncode(data));
    var jsonResponse = jsonDecode(response.body);
    print(jsonEncode(jsonResponse).toString());
    if (response.statusCode == 200) {
      print('success');
      finalResponse = {
        "code": 200,
        "message": "success",
        "model": response.body
      };
    } else {
      print('error');
      finalResponse = {
        "code": response.statusCode,
        "message": response.body,
      };
    }
  } catch (e) {
    finalResponse = {
      "code": 401,
      "message": e.toString(),
    };
  }
  print(finalResponse);
  return finalResponse;
}

Future<Map<String, dynamic>> getService(String url, String token) async {
  var finalResponse;

  User user = User();
  String authToken = "";

  try {
    await Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));
        if ((user.id)!.isEmpty) {
          //logout;
        } else {
          authToken = user.auth_key!;
          print("Auth Token $authToken");
        }
      }
    });

    final http.Response response = await http.get(
      Uri.parse("$urlApi$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    );
    var jsonResponse = jsonDecode(response.body);
    /* print(jsonEncode(jsonResponse).toString()); */
    if (response.statusCode == 200) {
      print('success');
      finalResponse = {
        "code": 200,
        "message": "success",
        "model": response.body
      };
    } else {
      print('error');
      finalResponse = {
        "code": response.statusCode,
        "message": response.body,
      };
    }
  } catch (e) {
    finalResponse = {
      "code": 401,
      "message": e.toString(),
    };
  }
  /* print(finalResponse); */
  return finalResponse;
}
