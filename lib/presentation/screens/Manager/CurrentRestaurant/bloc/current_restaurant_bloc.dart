import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/owned_restaurant.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/view/owned_restaurant_details.dart';
import 'package:equatable/equatable.dart';

part 'current_restaurant_event.dart';
part 'current_restaurant_state.dart';

class CurrentRestaurantBloc
    extends Bloc<CurrentRestaurantEvent, CurrentRestaurantState> {
  CurrentRestaurantBloc() : super(CurrentRestaurantInitial());

  @override
  Stream<CurrentRestaurantState> mapEventToState(
    CurrentRestaurantEvent event,
  ) async* {
    if (event is SetCurrentRestaurant) {
      yield SettingCurrentRestaurant();
      await Utils().startSharedPreferences().then((prefs) {
        prefs.setString("current_restaurant", jsonEncode(event.restaurant));
      });
      yield DoneSettingCurrentRestaurant(restaurant: event.restaurant);
    }
  }
}
