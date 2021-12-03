import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/table.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  BookingsBloc() : super(BookingsInitial());

  @override
  Stream<BookingsState> mapEventToState(BookingsEvent event) async* {
    if (event is LoadConfirmedBookings) {
      yield LoadingConfirmedBookings();

      var response = await getService(
          '/solicitude/?filter[status]=2&filter[restaurant_id]=' +
              event.restaurantId,
          "");
      if (response['code'] == 401) {
        print("Hubo un error para cargar la lista de reservaciones");
        yield FailedLoadingConfirmedBookings(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<ReservationModel> bookings = [];

        for (var i = 0; i < jsonRest.length; i++) {
          bookings.add(ReservationModel.fromJson(jsonRest[i]));
        }

        yield ConfirmedBookingListReady(bookings: bookings);
      } else {
        print("Hubo un error para cargar la lista de reservaciones");
        yield FailedLoadingConfirmedBookings(message: response.toString());
      }
    } else if (event is AssignTable) {
      yield AssigningTable();
      List<String> tableIds = [];
      List<TableModel> bookingTables = [];
      for (var i = 0; i < event.booking.tables.length; i++) {
        bookingTables.add(TableModel.fromJson(event.booking.tables[i]));
      }

      for (TableModel tableItem in bookingTables) {
        tableIds.add(tableItem.id);
      }
      if (event.removingTable) {
        tableIds.remove(event.tableId);
      } else {
        tableIds.add(event.tableId);
      }

      var data = {"id": event.booking.id, "table_ids": tableIds};

      var response =
          await postService(data, '/solicitude/${event.booking.id}/edit', "");
      if (Utils().successfulHTTPCode(response['code'])) {
        yield DoneAssigningTable();
      } else {
        yield FailedAssigningTable(message: response['message']);
      }
    } else if (event is UpdateBookingStatus) {
      yield UpdatingBooking();
      var model = jsonDecode(jsonEncode(event.booking));
      var data = model;

      var response =
          await postService(data, '/solicitude/${event.booking.id}/edit', "");
      if (Utils().successfulHTTPCode(response['code'])) {
        yield DoneUpdatingBooking();
      } else {
        yield FailedUpdatingBooking(message: response['message']);
      }
    } else if (event is ResetBookingsInstance) {
      yield BookingsInitial();
    }
  }
}
