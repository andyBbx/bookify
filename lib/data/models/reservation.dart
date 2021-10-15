import 'resturant.dart';

class Reservation {
  late RestaurantModel restaurantesData;
  late int person;
  late String time, info;

  Reservation(
      {required this.restaurantesData,
      required this.person,
      required this.info,
      required this.time});
}
