import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final context;

  RestaurantBloc(this.context) : super(RestaurantInitial());

  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    final currentState = state;

    if (event is LoadData) {
      var response = await getService('/restaurant');
      if (response['code'] == 401) {
        yield RestaurantFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<RestaurantModel> myRest = [];

        for (var i = 0; i < jsonRest.length; i++) {
          myRest.add(RestaurantModel.fromJson(jsonRest[i]));
        }
        if (myRest.isEmpty) {
          yield RestaurantEmptyDB();
        } else {
          yield RestaurantLoaded(restaurants: myRest);
        }
      }
    } else if (event is LoadFavData) {
      var response = await getService('/restaurant');
      if (response['code'] == 401) {
        yield RestaurantFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<RestaurantModel> myRest = [];

        for (var i = 0; i < jsonRest.length; i++) {
          var restModel = RestaurantModel.fromJson(jsonRest[i]);
          if (restModel.favorite == 1) {
            myRest.add(restModel);
          }
        }
        if (myRest.length == 0) {
          print('emptyyy');
          yield RestaurantEmptyDB();
        } else {
          yield RestaurantFavLoaded(restaurants: myRest);
        }
      }
    }
  }
}
