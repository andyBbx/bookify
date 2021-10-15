import 'dart:convert';
import 'package:bookify/data/models/user.dart';
import 'package:http/http.dart' as http;

class AuthRep {
  Future<void> login() async {
    print('attempting login');

    await Future.delayed(Duration(seconds: 2));
    print('logged in');
    // throw Exception('failed log in');
  }

  Future<Map<String, dynamic>> Signup(User userr) async {
    print('attempting signup');
    var finalResponse;

    try {
      final http.Response response = await http.post(
          Uri.parse("https://api.reservas.androidtemplates.es/v1/user/sign-up"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          /* body: jsonEncode({
            "firstname": userr.name,
            "middlename": userr.firstLastname,
            "lastname": userr.secondLastName,
            "email": userr.email,
            "password": userr.password,
            "is_manager": userr.isManager
          }) */
          body: jsonEncode(userr.toJson()));
      var jsonResponse = jsonDecode(response.body);
      print(jsonEncode(jsonResponse).toString());
      if (response.statusCode == 200) {
        print('signup success');
        finalResponse = {
          "code": 200,
          "message": "success",
          "model": response.body
        };
      } else {
        print('signup error');
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
}
