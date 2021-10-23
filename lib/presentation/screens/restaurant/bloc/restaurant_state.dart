part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
}

class RestaurantInitial extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantEmpty extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantEmptyDB extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoaded extends RestaurantState {
  const RestaurantLoaded({required this.restaurants});

  final dynamic restaurants;

  @override
  List<Object> get props => [restaurants];
}

class RestaurantFavLoaded extends RestaurantState {
  const RestaurantFavLoaded({required this.restaurants});

  final dynamic restaurants;

  @override
  List<Object> get props => [restaurants];
}

class RestaurantFail extends RestaurantState {
  const RestaurantFail({required this.message});

  final dynamic message;

  @override
  List<Object> get props => [message];
}
