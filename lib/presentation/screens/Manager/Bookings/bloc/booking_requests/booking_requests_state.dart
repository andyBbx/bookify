part of 'booking_requests_bloc.dart';

abstract class BookingRequestsState extends Equatable {
  const BookingRequestsState();
  
  @override
  List<Object> get props => [];
}

class BookingRequestsInitial extends BookingRequestsState {}

class LoadingUnconfirmedBookings extends BookingRequestsState {}
class UnconfirmedBookingListReady extends BookingRequestsState {
  final List<ReservationModel> bookings;

  const UnconfirmedBookingListReady({required this.bookings});

  @override
  List<Object> get props => [bookings];
}
class FailedLoadingUnconfirmedBookings extends BookingRequestsState {
  final String message;

  const FailedLoadingUnconfirmedBookings({required this.message});

  @override
  List<Object> get props => [message];
}