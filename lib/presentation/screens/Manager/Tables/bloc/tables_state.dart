part of 'tables_bloc.dart';

abstract class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object> get props => [];
}

class TablesInitial extends TablesState {}

class LoadingRestaurantTables extends TablesState {}

class ReadyRestaurantTables extends TablesState {
  final List tables;

  const ReadyRestaurantTables({required this.tables});

  @override
  List<Object> get props => [tables];
}

class FailedLoadingRestaurantTables extends TablesState {
  final String message;

  const FailedLoadingRestaurantTables({required this.message});

  @override
  List<Object> get props => [message];
}
