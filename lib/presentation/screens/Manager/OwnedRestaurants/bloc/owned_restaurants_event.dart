part of 'owned_restaurants_bloc.dart';

abstract class OwnedRestaurantsEvent extends Equatable {
  const OwnedRestaurantsEvent();

  @override
  List<Object> get props => [];
}

class LoadOwnedRestaurants extends OwnedRestaurantsEvent {
  const LoadOwnedRestaurants({required this.user});
  final User user;
  @override
  List<Object> get props => [user];
}

class CreateRestaurant extends OwnedRestaurantsEvent {
  const CreateRestaurant({required this.user, required this.restaurantModel});
  final User user;
  final RestaurantModel restaurantModel;
  @override
  List<Object> get props => [user, restaurantModel];
}