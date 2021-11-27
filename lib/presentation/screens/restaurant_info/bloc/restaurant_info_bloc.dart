import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'restaurant_info_event.dart';
part 'restaurant_info_state.dart';

class RestaurantInfoInfoBloc
    extends Bloc<RestaurantInfoEvent, RestaurantInfoState> {
  final context;

  RestaurantInfoInfoBloc(this.context) : super(RestaurantInfoInitial());

  @override
  Stream<RestaurantInfoState> mapEventToState(
    RestaurantInfoEvent event,
  ) async* {
    final currentState = state;

    if (event is LoadData) {
      var response = await getService('/restaurant', '');
      if (response['code'] == 401) {
        yield RestaurantInfoFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<RestaurantModel> myRest = [];

        for (var i = 0; i < jsonRest.length; i++) {
          myRest.add(RestaurantModel.fromJson(jsonRest[i]));
        }
        if (myRest.isEmpty) {
          yield RestaurantInfoEmptyDB();
        } else {
          yield RestaurantInfoLoaded(restaurants: myRest);
        }
      }
    } else if (event is LoadDate) {
      yield RestaurantInfoHoursLoading();

      List<dynamic> hoursList = [];

      for (var i = 0; i < event.times.length; i++) {
        const interval = Duration(minutes: 15);

        if (event.selectDate.weekday == event.times[i]["day"]) {
          for (var t = 0; t < event.times[i]['times'].length; t++) {
            var initHour = event.times[i]['times'][t]["init"];
            var endHour = event.times[i]['times'][t]["end"];

            final times = getTimeSlots(
                    TimeOfDay(
                        hour: int.parse(initHour.split(":")[0]),
                        minute: int.parse(initHour.split(":")[1])),
                    TimeOfDay(
                        hour: int.parse(endHour.split(":")[0]),
                        minute: int.parse(endHour.split(":")[1])),
                    interval)
                .toList();

            for (var j = 0; j < times.length; j++) {
              DateTime myTime = DateTime(
                  event.selectDate.year,
                  event.selectDate.month,
                  event.selectDate.day,
                  times[j].hour,
                  times[j].minute);
              if (myTime.isAfter(DateTime.now())) {
                hoursList.add(myTime);
              }
            }
          }
        }
      }
      yield RestaurantInfoHoursLoaded(listHours: hoursList);
    } else if (event is CreateReservation) {
      yield CreateReservationLoad();
      // yield CreateReservationSuccess();
      var data = {
        "client_id": event.reservationModel.clientId,
        "restaurant_id": event.reservationModel.restaurantData.id,
        "quantity": event.reservationModel.quantity,
        "time": DateFormat()
            .add_Hms()
            .format(DateTime.parse(event.reservationModel.time))
            .toString(),
        "date": event.reservationModel.date.toString(),
      };
      var response =
          await postService(data, '/solicitude/create', event.user.auth_key!);
      if (response['code'] == 401) {
        yield CreateReservationRestaurantFail(message: response['message']);
      } else if (response['code'] == 200 || response['code'] == 201) {
        yield CreateReservationSuccess();
      } else {
        yield CreateReservationRestaurantFail(message: response['message']);
      }
    }
  }
}
