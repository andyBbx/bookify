part of 'current_restaurant_bloc.dart';

abstract class CurrentRestaurantState extends Equatable {
  const CurrentRestaurantState();
  
  @override
  List<Object> get props => [];
}

class CurrentRestaurantInitial extends CurrentRestaurantState {}
