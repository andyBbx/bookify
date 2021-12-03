part of 'current_restaurant_bloc.dart';

abstract class CurrentRestaurantEvent extends Equatable {
  const CurrentRestaurantEvent();

  @override
  List<Object> get props => [];
}

class SetCurrentRestaurant extends CurrentRestaurantEvent {
  final OwnedRestaurantModel restaurant;
  const SetCurrentRestaurant({required this.restaurant});
  @override
  List<Object> get props => [restaurant];
}
