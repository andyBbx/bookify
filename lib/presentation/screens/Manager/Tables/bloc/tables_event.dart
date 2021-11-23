part of 'tables_bloc.dart';

abstract class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurantTables extends TablesEvent {
  final String restaurantId;
  final User user;

  const LoadRestaurantTables({required this.user, required this.restaurantId});

  @override
  List<Object> get props => [user, restaurantId];
}
