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

      var data = {
        "restaurant_id": event.restaurantId,
        "date": DateFormat('yyyy-MM-dd').format(event.selectDate)
      };

      print(data);

      var response = await postService(data, '/restaurant/hours', '');
      if (response['code'] != 200) {
        print(response);
      } else if (response['code'] == 200) {
        print(response);
        var jsonRest = jsonDecode(response['model']);
        jsonRest.forEach((key, value) {
          var splited = key.split(':');
          int slotHour = int.parse(splited[0]);
          int slotMinute = int.parse(splited[1]);
          DateTime timeSlot = DateTime(DateTime.now().year,
              DateTime.now().month, DateTime.now().day, slotHour, slotMinute);
          if (timeSlot.isAfter(DateTime.now())) {
            /* print("Is after: "+timeSlot.toString()); */
            /* if (value == 1) {
              hoursList.add(timeSlot);
            } */
            bool slotEnabled = value == 1 ? true : false;
            hoursList.add({"slot": timeSlot, "enabled": slotEnabled});
          }
          /* print('key is $key');
          print('value is $value '); */
        });
      }

      /* for (var i = 0; i < event.times.length; i++) {
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
      } */
      yield RestaurantInfoHoursLoaded(listHours: hoursList);
    } else if (event is CreateReservation) {
      yield CreateReservationLoad();
      // yield CreateReservationSuccess();
      bool nowActive = false;

      String bookingTimeString = DateFormat()
          .add_Hms()
          .format(DateTime.parse(event.reservationModel.time))
          .toString();

      TimeOfDay bookingTime = TimeOfDay(
          hour: int.parse(bookingTimeString.split(":")[0]),
          minute: int.parse(bookingTimeString.split(":")[1]));

      Utils().bprint(bookingTime);

      TimeOfDay nowTime = TimeOfDay.now();
      TimeOfDay nowPlusOneHour =
          nowTime.replacing(hour: nowTime.hour + 1, minute: nowTime.minute);

      Utils().bprint(nowPlusOneHour);
      Utils().bprint(nowPlusOneHour.format(context));

      DateTime bookingDate = DateTime.parse(
          DateFormat('yyyy-MM-dd').format(event.reservationModel.date));
      DateTime nowDate =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

      /* print("Fecha reserva");
      print(bookingDate);
      print("Fecha ahora");
      print(nowDate); */

      var nowPlusOneHourParsedTime =
          DateTime.parse('2022-01-01 ${nowPlusOneHour.format(context)}');
      var bookingParsedTime =
          DateTime.parse('2022-01-01 ${bookingTime.format(context)}');
      Utils().bprint(bookingParsedTime.isAfter(nowPlusOneHourParsedTime));

      int bookingStatus = 1;
      if (bookingDate.isAfter(nowDate)) {
        bookingStatus = 2;
      } else {
        if (bookingParsedTime.isAfter(nowPlusOneHourParsedTime)) {
          bookingStatus = 2;
        } else {
          nowActive = true;
        }
      }

      var data = {
        "client_id": event.reservationModel.clientId,
        "restaurant_id": event.reservationModel.restaurantData.id,
        "quantity": event.reservationModel.quantity,
        "status": bookingStatus,
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
        yield CreateReservationSuccess(nowActive: nowActive);
      } else {
        yield CreateReservationRestaurantFail(message: response['message']);
      }
    }
  }
}
