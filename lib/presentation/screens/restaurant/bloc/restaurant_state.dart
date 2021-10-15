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
  RestaurantLoaded({required this.restaurants});

  final dynamic restaurants;

  @override
  List<Object> get props => [restaurants];
}
