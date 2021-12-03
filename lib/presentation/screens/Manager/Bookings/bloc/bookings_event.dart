part of 'bookings_bloc.dart';

abstract class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

class LoadConfirmedBookings extends BookingsEvent {
  final String restaurantId;

  const LoadConfirmedBookings({required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}

class AssignTable extends BookingsEvent {
  final String tableId;
  final ReservationModel booking;
  final removingTable;

  const AssignTable({required this.tableId,required this.booking, required this.removingTable});

  @override
  List<Object> get props => [tableId,booking];
}

class RemoveTable extends BookingsEvent {
  final String tableId;
  final ReservationModel booking;

  const RemoveTable({required this.tableId,required this.booking});

  @override
  List<Object> get props => [tableId,booking];
}

class UpdateBookingStatus extends BookingsEvent {
  final ReservationModel booking;

  const UpdateBookingStatus({required this.booking});

  @override
  List<Object> get props => [booking];
}

class ResetBookingsInstance extends BookingsEvent {}
