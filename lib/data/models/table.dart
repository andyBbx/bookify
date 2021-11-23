import 'dart:convert';

TableModel restaurantModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String restaurantModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  String id;
  String restaurant_id;
  String name;
  int quantity;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  TableModel({
    required this.id,
    required this.restaurant_id,
    required this.name,
    required this.quantity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        restaurant_id: json["restaurant_id"],
        name: json["name"],
        quantity: int.parse(json["quantity"]),
        status: json["status"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurant_id,
        "name": name,
        "quantity": quantity,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String()
      };
}
