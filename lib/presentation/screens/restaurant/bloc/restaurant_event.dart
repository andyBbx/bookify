part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends RestaurantEvent {
  @override
  List<Object> get props => [];
}
