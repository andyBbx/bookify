import 'dart:convert';

OfferModel offerModelFromJson(String str) =>
    OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
  OfferModel({
    this.id,
    this.restaurantId,
    this.image,
    this.name,
    this.url,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? restaurantId;
  String? image;
  String? name;
  String? url;
  DateTime? startDate;
  DateTime? endDate;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        image: json["image"],
        name: json["name"],
        url: json["url"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "image": image,
        "name": name,
        "url": url,
        "start_date": startDate!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
