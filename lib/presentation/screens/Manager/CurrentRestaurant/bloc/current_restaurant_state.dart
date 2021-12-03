part of 'current_restaurant_bloc.dart';

abstract class CurrentRestaurantState extends Equatable {
  const CurrentRestaurantState();
  
  @override
  List<Object> get props => [];
}

class SettingCurrentRestaurant extends CurrentRestaurantState {}
class DoneSettingCurrentRestaurant extends CurrentRestaurantState {
  final OwnedRestaurantModel restaurant;
  const DoneSettingCurrentRestaurant({required this.restaurant});
  @override
  List<Object> get props => [restaurant];
}

class CurrentRestaurantInitial extends CurrentRestaurantState {}
