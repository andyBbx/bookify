part of 'table_bloc.dart';

abstract class TableState extends Equatable {
  const TableState();
  
  @override
  List<Object> get props => [];
}

class TableInitial extends TableState {}
class CreatingTable extends TableState {}
class DoneCreatingTable extends TableState {}
class FailedCreatingTable extends TableState {
  final String message;

  const FailedCreatingTable({required this.message});

  @override
  List<Object> get props => [message];
}

class SwappingTable extends TableState {}
class DoneSwappingTable extends TableState {}
class FailedSwappingTable extends TableState {
  final String message;

  const FailedSwappingTable({required this.message});

  @override
  List<Object> get props => [message];
}
