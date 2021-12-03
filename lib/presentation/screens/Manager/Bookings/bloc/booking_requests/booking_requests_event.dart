part of 'booking_requests_bloc.dart';

abstract class BookingRequestsEvent extends Equatable {
  const BookingRequestsEvent();

  @override
  List<Object> get props => [];
}

class LoadUnconfirmedBookings extends BookingRequestsEvent {
  final String restaurantId;

  const LoadUnconfirmedBookings({required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}

class ResetBookingRequestsInstance extends BookingRequestsEvent {}
