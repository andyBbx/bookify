part of 'restaurant_info_bloc.dart';

abstract class RestaurantInfoEvent extends Equatable {
  const RestaurantInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends RestaurantInfoEvent {
  @override
  List<Object> get props => [];
}

class LoadDate extends RestaurantInfoEvent {
  const LoadDate({required this.times, required this.selectDate, required this.restaurantId});
  final dynamic times;
  final DateTime selectDate;
  final  String restaurantId;

  @override
  List<Object> get props => [times, selectDate];
}

class CreateReservation extends RestaurantInfoEvent {
  const CreateReservation({required this.reservationModel, required this.user});
  final ReservationModel reservationModel;
  final User user;

  @override
  List<Object> get props => [reservationModel, user];
}
