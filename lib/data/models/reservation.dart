// To parse this JSON data, do
//
//     final reservsaModel = reservsaModelFromJson(jsonString);

import 'dart:convert';

import 'package:bookify/data/models/resturant.dart';

ReservationModel reservsaModelFromJson(String str) =>
    ReservationModel.fromJson(json.decode(str));

String reservsaModelToJson(ReservationModel data) => json.encode(data.toJson());

class ReservationModel {
  ReservationModel({
    required this.id,
    required this.clientId,
    required this.restaurantData,
    required this.time,
    required this.date,
    this.observation,
    this.rated,
    this.status,
    this.createdAt,
    this.updatedAt,
    required this.quantity,
  });

  String id;
  String clientId;
  dynamic restaurantData;
  String time;
  DateTime date;
  String? observation;
  String? rated;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic quantity;

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        id: json["id"],
        clientId: json["client_id"],
        restaurantData: json["restaurant_data"],
        time: json["time"],
        date: DateTime.parse(json["date"]),
        observation: json["observation"],
        rated: json["rated"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "restaurant_data": restaurantData,
        "time": time,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "observation": observation,
        "rated": rated,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "quantity": quantity
      };
}
