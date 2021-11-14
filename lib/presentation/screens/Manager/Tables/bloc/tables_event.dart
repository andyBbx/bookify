part of 'tables_bloc.dart';

abstract class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurantTables extends TablesEvent {
  const LoadRestaurantTables();

  @override
  List<Object> get props => [];
}
