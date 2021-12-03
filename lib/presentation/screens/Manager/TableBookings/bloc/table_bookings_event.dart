part of 'table_bookings_bloc.dart';

abstract class TableBookingsEvent extends Equatable {
  const TableBookingsEvent();

  @override
  List<Object> get props => [];
}

class LoadTableBookings extends TableBookingsEvent {
  final String tableId;

  const LoadTableBookings({required this.tableId});

  @override
  List<Object> get props => [tableId];
}

class ClearTableFromBooking extends TableBookingsEvent {
  final String tableId;
  final String bookingId;

  const ClearTableFromBooking({required this.tableId,required this.bookingId});

  @override
  List<Object> get props => [tableId];
}

class ResetTableBookingsInstance extends TableBookingsEvent {}