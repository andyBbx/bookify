part of 'owned_restaurants_bloc.dart';

abstract class OwnedRestaurantsState extends Equatable {
  const OwnedRestaurantsState();
  
  @override
  List<Object> get props => [];
}

class OwnedRestaurantsInitial extends OwnedRestaurantsState {}

class LoadingOwnedRestaurants extends OwnedRestaurantsState {}

class ReadyOwnedRestaurants extends OwnedRestaurantsState {
    const ReadyOwnedRestaurants({required this.restaurants});

  final List restaurants;

  @override
  List<Object> get props => [restaurants];
}

class FailedLoadingOwnedRestaurants extends OwnedRestaurantsState {
  const FailedLoadingOwnedRestaurants({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}