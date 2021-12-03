part of 'bookings_bloc.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();
  
  @override
  List<Object> get props => [];
}

class BookingsInitial extends BookingsState {}

class LoadingConfirmedBookings extends BookingsState {}
class ConfirmedBookingListReady extends BookingsState {
  final List<ReservationModel> bookings;

  const ConfirmedBookingListReady({required this.bookings});

  @override
  List<Object> get props => [bookings];
}
class FailedLoadingConfirmedBookings extends BookingsState {
  final String message;

  const FailedLoadingConfirmedBookings({required this.message});

  @override
  List<Object> get props => [message];
}


class AssigningTable extends BookingsState {}
class FailedAssigningTable extends BookingsState {
  final String message;

  const FailedAssigningTable({required this.message});

  @override
  List<Object> get props => [message];
}
class DoneAssigningTable extends BookingsState {}


class RemovingTable extends BookingsState {}
class FailedRemovingTable extends BookingsState {
  final String message;

  const FailedRemovingTable({required this.message});

  @override
  List<Object> get props => [message];
}
class DoneRemovingTable extends BookingsState {}


class UpdatingBooking extends BookingsState {}
class FailedUpdatingBooking extends BookingsState {
  final String message;

  const FailedUpdatingBooking({required this.message});

  @override
  List<Object> get props => [message];
}
class DoneUpdatingBooking extends BookingsState {}