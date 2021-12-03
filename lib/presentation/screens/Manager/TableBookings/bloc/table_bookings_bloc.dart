import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';

part 'table_bookings_event.dart';
part 'table_bookings_state.dart';

class TableBookingsBloc extends Bloc<TableBookingsEvent, TableBookingsState> {
  TableBookingsBloc() : super(TableBookingsInitial());

  @override
  Stream<TableBookingsState> mapEventToState(TableBookingsEvent event) async* {
    if (event is LoadTableBookings) {
      yield LoadingTableBookings();

      var response =
          await getService('/table/${event.tableId}/solicitudes', "");
      if (Utils().successfulHTTPCode(response['code'])) {
        var jsonRest = jsonDecode(response['model']);
        List<ReservationModel> bookings = [];

        for (var i = 0; i < jsonRest.length; i++) {
          bookings.add(ReservationModel.fromJson(jsonRest[i]));
        }

        yield TableBookingListReady(bookings: bookings);
      } else {
        print("Hubo un error para cargar la lista de reservaciones");
        yield FailedLoadingTableBookings(message: response['message']);
      }
    } else if (event is ClearTableFromBooking) {
      yield ClearingTable();
      var data = {"id":event.tableId,"solicitude_ids": event.bookingId};
      var response =
          await postService(data, '/table/${event.tableId}/clear-table', "");
      if (Utils().successfulHTTPCode(response['code'])) {
        yield DoneClearingTable();
      } else {
        yield FailedClearingTable(message: response['message']);
      }
    } else if (event is ResetTableBookingsInstance) {
      yield TableBookingsInitial();
    }
  }
}
