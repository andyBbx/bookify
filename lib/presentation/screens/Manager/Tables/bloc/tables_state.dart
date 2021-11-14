part of 'tables_bloc.dart';

abstract class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object> get props => [];
}

class TablesInitial extends TablesState {}

class LoadingRestaurantTables extends TablesState {}

class FailedLoadingRestaurantTables extends TablesState {
  final String message;

  const FailedLoadingRestaurantTables({required this.message});

  @override
  List<Object> get props => [message];
}
