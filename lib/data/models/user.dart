import 'package:bookify/data/models/location.dart';

class User {
  String? email,
      phone,
      firstname,
      middlename,
      lastname,
      id,
      password,
      avatar,
      auth_key;
  List favorite_restaurants;
  bool isManager;
  int status;
  Location? location;

  User(
      {this.id = "",
      this.avatar = "",
      this.auth_key = "",
      this.firstname = "",
      this.middlename = "",
      this.lastname = "",
      this.email = "",
      this.password = "",
      this.phone = "",
      this.favorite_restaurants = const [],
      this.status = 0,
      this.isManager = false});

  Map<String, dynamic> toJson() => {
        'id': id,
        'avatar': avatar,
        'auth_key': auth_key,
        'firstname': firstname,
        'middlename': middlename,
        'lastname': lastname,
        'email': email,
        'password': password,
        'phone': phone,
        'favorite_restaurants': favorite_restaurants,
        'status': status
      };

  fromJson(Map<String, dynamic> parsedJson) {
    return User(
        id: parsedJson["id"].toString(),
        avatar: parsedJson["avatar"].toString(),
        auth_key: parsedJson["auth_key"].toString(),
        firstname: parsedJson["firstname"].toString(),
        middlename: parsedJson["middlename"].toString(),
        lastname: parsedJson["lastname"].toString(),
        email: parsedJson["email"].toString(),
        password: parsedJson["password"].toString(),
        phone: parsedJson["phone"].toString(),
        favorite_restaurants: parsedJson["favorite_restaurants"],
        status: parsedJson["status"] ?? 0);
  }
}
