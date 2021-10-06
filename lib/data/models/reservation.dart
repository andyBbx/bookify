import 'resturant.dart';

class Reservation {
  late ReturantData restaurantesData;
  late int person;
  late String time, info;

  Reservation(
      {required this.restaurantesData,
      required this.person,
      required this.info,
      required this.time});
}
