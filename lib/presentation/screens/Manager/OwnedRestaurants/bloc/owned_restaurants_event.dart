part of 'owned_restaurants_bloc.dart';

abstract class OwnedRestaurantsEvent extends Equatable {
  const OwnedRestaurantsEvent();

  @override
  List<Object> get props => [];
}

class LoadOwnedRestaurants extends OwnedRestaurantsEvent {}

class CreateRestaurant extends OwnedRestaurantsEvent {
  const CreateRestaurant({required this.restaurantModel, required this.base64Logo});
  final OwnedRestaurantModel restaurantModel;
  final String base64Logo;
  @override
  List<Object> get props => [restaurantModel, base64Logo];
}

class UpdateOwnedRestaurant extends OwnedRestaurantsEvent {
  const UpdateOwnedRestaurant({required this.restaurantModel, required this.base64Logo});
  final OwnedRestaurantModel restaurantModel;
  final String base64Logo;
  @override
  List<Object> get props => [restaurantModel, base64Logo];
}
