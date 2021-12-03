part of 'table_bloc.dart';

abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class CreateTable extends TableEvent {
  final TableModel table;

  const CreateTable({required this.table});

  @override
  List<Object> get props => [table];
}

class SwapTable extends TableEvent {
  final String originTableId;
  final String originBookingId;
  final String destinationTableId;
  final String destinationBookingId;

  const SwapTable(
      {required this.originTableId,
      required this.originBookingId,
      required this.destinationTableId,
      required this.destinationBookingId});

  @override
  List<Object> get props => [
        originTableId,
        originBookingId,
        destinationTableId,
        destinationBookingId
      ];
}

class ResetTableInstance extends TableEvent {}
