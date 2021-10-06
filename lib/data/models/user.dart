import 'package:bookify/data/models/location.dart';

class Userr {
  String? username, email, phone, suername, secondname, id, password;
  Location? location;

  Userr(
      {this.username = "",
      this.email = "",
      this.phone = "",
      this.suername = "",
      this.secondname = "",
      this.id = "",
      this.location,
      this.password = ""});

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'phone': phone,
        'surename': suername,
        'secondname': secondname,
        'id': id,
        'password': password,
      };

  fromJson(Map<String, dynamic> parsedJson) {
    return Userr(
      username: parsedJson['username'].toString(),
      email: parsedJson['name'].toString(),
      phone: parsedJson['phone'].toString(),
      id: parsedJson['id'].toString(),
      suername: parsedJson['surname'].toString(),
      secondname: parsedJson['secondname'].toString(),
      password: parsedJson['password'].toString(),
    );
  }
}
