part of 'owned_restaurants_bloc.dart';

abstract class OwnedRestaurantsEvent extends Equatable {
  const OwnedRestaurantsEvent();

  @override
  List<Object> get props => [];
}

class LoadOwnedRestaurants extends OwnedRestaurantsEvent {}

class CreateRestaurant extends OwnedRestaurantsEvent {
  const CreateRestaurant({required this.restaurantModel, required this.base64Logo, required this.base64MenuFile});
  final OwnedRestaurantModel restaurantModel;
  final String base64Logo;
  final String base64MenuFile;
  @override
  List<Object> get props => [restaurantModel, base64Logo, base64MenuFile];
}

class UpdateOwnedRestaurant extends OwnedRestaurantsEvent {
  const UpdateOwnedRestaurant({required this.restaurantModel, required this.base64Logo, required this.base64MenuFile});
  final OwnedRestaurantModel restaurantModel;
  final String base64Logo;
  final String base64MenuFile;
  @override
  List<Object> get props => [restaurantModel, base64Logo, base64MenuFile];
}
