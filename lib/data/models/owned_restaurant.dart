import 'dart:convert';

OwnedRestaurantModel restaurantModelFromJson(String str) =>
    OwnedRestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(OwnedRestaurantModel data) =>
    json.encode(data.toJson());

class OwnedRestaurantModel {
  OwnedRestaurantModel({
    required this.id,
    required this.logo,
    required this.name,
    required this.description,
    required this.phone,
    required this.address,
    required this.postalCode,
    required this.municipality,
    required this.province,
    required this.country,
    required this.web,
    required this.rating,
    required this.menuUrl,
    required this.latitude,
    required this.longitude
  });

  String id;
  dynamic cover;
  String logo;
  String name;
  String description;
  String phone;
  String address;
  String postalCode;
  String municipality;
  String province;
  String country;
  String web;
  dynamic rating;
  dynamic latitude;
  dynamic longitude;
  String menuUrl;

  factory OwnedRestaurantModel.fromJson(Map<String, dynamic> json) =>
      OwnedRestaurantModel(
          id: json["id"],
          logo: json["logo"] ?? "",
          name: json["name"],
          description: json["description"],
          phone: json["phone"],
          address: json["address"],
          postalCode: json["postal_code"],
          municipality: json["municipality"],
          province: json["province"],
          country: json["country"],
          web: json["web"] ?? "",
          rating: json["rating"],
          latitude: json["latitude"],
          longitude: json["longitude"],
          menuUrl: json["menu_url"] ?? "",
          );

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
        "web": web,
        "rating": rating,
        "longitude": longitude,
        "latitude": latitude,
        "menu_url": menuUrl
      };
}
