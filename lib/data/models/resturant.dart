// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel {
  RestaurantModel({
    required this.id,
    this.cover,
    required this.name,
    required this.description,
    required this.phone,
    required this.address,
    required this.postalCode,
    required this.municipality,
    required this.province,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.web,
    required this.tags,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  dynamic cover;
  String name;
  String description;
  String phone;
  String address;
  String postalCode;
  String municipality;
  String province;
  String country;
  String latitude;
  String longitude;
  String web;
  List<dynamic> tags;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        description: json["description"],
        phone: json["phone"],
        address: json["address"],
        postalCode: json["postal_code"],
        municipality: json["municipality"],
        province: json["province"],
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        web: json["web"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "description": description,
        "phone": phone,
        "address": address,
        "postal_code": postalCode,
        "municipality": municipality,
        "province": province,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "web": web,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class RestaurantData extends Equatable {
  late List<RestaurantModel> data;

  //Mocked
  RestaurantData.fromMocked() {
    this.data = [
      RestaurantModel(
          id: '12345',
          name: 'My restaurant',
          description: 'aglsngl lsjf',
          phone: '123456',
          address: 'sgdhfjrhgsfad',
          postalCode: 's234567',
          municipality: 'sfghb',
          province: 'sdhgfdd',
          country: 'ASDFHRES',
          latitude: '23',
          longitude: '6',
          web: 'SDHRTF',
          tags: ['FSF', 'sf'],
          status: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now())
    ];
  }

  @override
  List<Object> get props => [
        data,
      ];
}
