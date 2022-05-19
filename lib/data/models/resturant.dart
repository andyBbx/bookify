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
  RestaurantModel(
      {this.id,
      this.cover,
      this.name,
      this.description,
      this.phone,
      this.address,
      this.postalCode,
      this.municipality,
      this.province,
      this.country,
      this.latitude,
      this.longitude,
      this.web,
      required this.tags,
      this.status,
      required this.createdAt,
      required this.updatedAt,
      this.favorite,
      this.rating,
      this.schedule,
      this.logo,
      this.rss,
      // ignore: non_constant_identifier_names
      this.menu_url,
      this.currentlyOpen: true,
      this.closestOpeningDate: ""});

  String? id;
  dynamic? cover;
  String? name;
  String? description;
  String? phone;
  String? address;
  String? postalCode;
  String? municipality;
  String? province;
  String? country;
  String? latitude;
  String? longitude;
  String? web;
  List<dynamic> tags;
  int? status;
  DateTime createdAt;
  DateTime updatedAt;
  int? favorite;
  dynamic? rating;
  dynamic? schedule;
  String? logo;
  dynamic rss;
  String? menu_url;
  bool currentlyOpen = true;
  String closestOpeningDate = "";

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
          id: json["id"],
          logo: json["logo"] ?? "",
          cover: json["cover"],
          name: json["name"],
          description: json["description"],
          phone: json["phone"],
          address: json["address"],
          postalCode: json["postal_code"],
          municipality: json["municipality"],
          province: json["province"],
          country: json["country"],
          latitude: json["latitude"] ?? "",
          longitude: json["longitude"] ?? "",
          web: json["web"] ?? "",
          tags: json["tags"] != null
              ? List<dynamic>.from(json["tags"].map((x) => x))
              : [],
          status: json["status"],
          createdAt: DateTime.parse(json["created_at"]),
          updatedAt: DateTime.parse(json["updated_at"]),
          favorite: json["favorite"] ?? 0,
          rating: json["rating"],
          schedule: json["schedule"],
          rss: json["rss"],
          menu_url: json["menu_url"],
          currentlyOpen: json["currently_open"] ?? true,
          closestOpeningDate: json["closest_opening_date"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
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
        "favorite": favorite,
        "rating": rating,
        "schedule": schedule,
        "logo": logo,
        "rss": rss,
        "menu_url": menu_url,
        "currently_open": currentlyOpen,
        "closest_opening_date": closestOpeningDate
      };
}

// class RestaurantData extends Equatable {
//   late List<RestaurantModel> data;

//   //Mocked
//   RestaurantData.fromMocked() {
//     this.data = [
//       RestaurantModel(
//           id: '12345',
//           name: 'My restaurant 1',
//           description: 'Restaurante Test 1',
//           phone: '123456',
//           address: 'Restaurante Test 1',
//           postalCode: '12345',
//           municipality: 'Restaurante Test 1',
//           province: 'Restaurante Test 1',
//           country: 'Restaurante Test 1',
//           latitude: '23',
//           longitude: '6',
//           web: 'SDHRTF',
//           tags: ['FSF', 'sf'],
//           status: 1,
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now()),
//       RestaurantModel(
//           id: '12345',
//           name: 'My restaurant 2',
//           description: 'Restaurante Test 2',
//           phone: '123456',
//           address: 'Restaurante Test 2',
//           postalCode: '12345',
//           municipality: 'Restaurante Test 2',
//           province: 'Restaurante Test 2',
//           country: 'Restaurante Test 2',
//           latitude: '23',
//           longitude: '6',
//           web: 'SDHRTF',
//           tags: ['FSF', 'sf'],
//           status: 1,
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now()),
//       RestaurantModel(
//           id: '12345',
//           name: 'My restaurant 3',
//           description: 'Restaurante Test 3',
//           phone: '123456',
//           address: 'Restaurante Test',
//           postalCode: '1234',
//           municipality: 'Restaurante Test 3',
//           province: 'Restaurante Test 3',
//           country: 'Restaurante Test 3',
//           latitude: '23',
//           longitude: '6',
//           web: 'SDHRTF',
//           tags: ['FSF', 'sf'],
//           status: 1,
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now())
//     ];
//   }

//   @override
//   List<Object> get props => [
//         data,
//       ];
// }
