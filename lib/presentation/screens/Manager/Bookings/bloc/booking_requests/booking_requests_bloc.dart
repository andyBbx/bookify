import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';

part 'booking_requests_event.dart';
part 'booking_requests_state.dart';

class BookingRequestsBloc
    extends Bloc<BookingRequestsEvent, BookingRequestsState> {
  BookingRequestsBloc() : super(BookingRequestsInitial());

  @override
  Stream<BookingRequestsState> mapEventToState(
      BookingRequestsEvent event) async* {
    if (event is LoadUnconfirmedBookings) {
      yield LoadingUnconfirmedBookings();

      var response = await getService(
          '/solicitude/?filter[status]=1&filter[restaurant_id]=' +
              event.restaurantId,
          "");
      if (response['code'] == 401) {
        print("Hubo un error para cargar la lista de reservaciones");
        yield FailedLoadingUnconfirmedBookings(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<ReservationModel> bookings = [];

        for (var i = 0; i < jsonRest.length; i++) {
          bookings.add(ReservationModel.fromJson(jsonRest[i]));
        }

        yield UnconfirmedBookingListReady(bookings: bookings);
      } else {
        print("Hubo un error para cargar la lista de reservaciones");
        yield FailedLoadingUnconfirmedBookings(message: response.toString());
      }
    } else if (event is ResetBookingRequestsInstance) {
      yield BookingRequestsInitial();
    }
  }
}
