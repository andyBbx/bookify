import 'package:bookify/data/models/user.dart';

class AuthRep {
  Future<void> login() async {
    print('attempting login');

    await Future.delayed(Duration(seconds: 2));
    print('logged in');
    // throw Exception('failed log in');
  }

  Future<Map<String, dynamic>> Signup(Userr userr) async {
    print('attempting signup');

    await Future.delayed(Duration(seconds: 2));
    print('signup success');
    return {
      "code": 200,
      "msg": "success",
    };
    // throw Exception('failed log in');
  }
}
