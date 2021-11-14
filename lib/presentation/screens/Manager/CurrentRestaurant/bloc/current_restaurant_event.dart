part of 'current_restaurant_bloc.dart';

abstract class CurrentRestaurantEvent extends Equatable {
  const CurrentRestaurantEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentRestaurantData extends CurrentRestaurantEvent {
  const LoadCurrentRestaurantData();
  @override
  List<Object> get props => [];
}
