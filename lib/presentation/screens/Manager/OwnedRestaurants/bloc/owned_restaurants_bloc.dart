import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';

part 'owned_restaurants_event.dart';
part 'owned_restaurants_state.dart';

class OwnedRestaurantsBloc
    extends Bloc<OwnedRestaurantsEvent, OwnedRestaurantsState> {
  final context;

  OwnedRestaurantsBloc(this.context) : super(OwnedRestaurantsInitial());

  @override
  Stream<OwnedRestaurantsState> mapEventToState(
    OwnedRestaurantsEvent event,
  ) async* {

    if (event is LoadOwnedRestaurants) {
      yield LoadingOwnedRestaurants();

      var response =
          await getService('/user/manager-restaurants', event.user.auth_key!);
      if (response['code'] == 401) {
        yield FailedLoadingOwnedRestaurants(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<RestaurantModel> myRest = [];

        for (var i = 0; i < jsonRest.length; i++) {
          myRest.add(RestaurantModel.fromJson(jsonRest[i]));
        }
        yield ReadyOwnedRestaurants(restaurants: myRest);
      } else {
        yield FailedLoadingOwnedRestaurants(message: response.toString());
      }
    }
  }
}
