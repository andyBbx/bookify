part of 'table_bookings_bloc.dart';

abstract class TableBookingsState extends Equatable {
  const TableBookingsState();
  
  @override
  List<Object> get props => [];
}

class TableBookingsInitial extends TableBookingsState {}

class LoadingTableBookings extends TableBookingsState {}
class TableBookingListReady extends TableBookingsState {
  final List<ReservationModel> bookings;

  const TableBookingListReady({required this.bookings});

  @override
  List<Object> get props => [bookings];
}
class FailedLoadingTableBookings extends TableBookingsState {
  final String message;

  const FailedLoadingTableBookings({required this.message});

  @override
  List<Object> get props => [message];
}


class ClearingTable extends TableBookingsState {}
class FailedClearingTable extends TableBookingsState {
  final String message;

  const FailedClearingTable({required this.message});

  @override
  List<Object> get props => [message];
}
class DoneClearingTable extends TableBookingsState {}