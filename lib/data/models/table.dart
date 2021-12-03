import 'dart:convert';

TableModel restaurantModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String restaurantModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  String id;
  String restaurant_id;
  String name;
  String quantity;
  int available;
  int status;

  TableModel({
    required this.id,
    required this.restaurant_id,
    required this.name,
    required this.quantity,
    required this.available,
    required this.status,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        restaurant_id: json["restaurant_id"],
        name: json["name"],
        quantity: json["quantity"],
        available: json["available"] ?? 0,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurant_id,
        "name": name,
        "quantity": quantity,
        "available": available,
        "status": status,
      };
}
