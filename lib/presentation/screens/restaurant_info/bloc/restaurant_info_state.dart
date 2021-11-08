part of 'restaurant_info_bloc.dart';

abstract class RestaurantInfoState extends Equatable {
  const RestaurantInfoState();
}

class RestaurantInfoInitial extends RestaurantInfoState {
  @override
  List<Object> get props => [];
}

class RestaurantInfoLoading extends RestaurantInfoState {
  @override
  List<Object> get props => [];
}

class RestaurantInfoEmpty extends RestaurantInfoState {
  @override
  List<Object> get props => [];
}

class RestaurantInfoEmptyDB extends RestaurantInfoState {
  @override
  List<Object> get props => [];
}

class RestaurantInfoLoaded extends RestaurantInfoState {
  const RestaurantInfoLoaded({required this.restaurants});

  final dynamic restaurants;

  @override
  List<Object> get props => [restaurants];
}

class RestaurantInfoHoursLoading extends RestaurantInfoState {
  @override
  List<Object> get props => [];
}

class RestaurantInfoHoursLoaded extends RestaurantInfoState {
  const RestaurantInfoHoursLoaded({required this.listHours});

  final dynamic listHours;

  @override
  List<Object> get props => [listHours];
}

class RestaurantInfoFail extends RestaurantInfoState {
  const RestaurantInfoFail({required this.message});

  final dynamic message;

  @override
  List<Object> get props => [message];
}

class CreateReservationLoad extends RestaurantInfoState {
  @override
  List<Object> get props => [];
}

class CreateReservationSuccess extends RestaurantInfoState {
  @override
  List<Object> get props => [];
}

class CreateReservationRestaurantFail extends RestaurantInfoState {
  const CreateReservationRestaurantFail({required this.message});

  final dynamic message;

  @override
  List<Object> get props => [message];
}
