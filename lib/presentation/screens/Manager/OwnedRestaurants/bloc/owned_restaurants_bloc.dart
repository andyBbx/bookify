import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/owned_restaurant.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'owned_restaurants_event.dart';
part 'owned_restaurants_state.dart';

class OwnedRestaurantsBloc
    extends Bloc<OwnedRestaurantsEvent, OwnedRestaurantsState> {
  final context;

  OwnedRestaurantsBloc(this.context) : super(OwnedRestaurantsInitial());

  bool hasValidUrl(String url) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(url);
  }

  @override
  Stream<OwnedRestaurantsState> mapEventToState(
    OwnedRestaurantsEvent event,
  ) async* {
    if (event is LoadOwnedRestaurants) {
      yield LoadingOwnedRestaurants();

      var response = await getService('/user/manager-restaurants', '');
      if (response['code'] == 401) {
        yield FailedLoadingOwnedRestaurants(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<OwnedRestaurantModel> ownedRestaurants = [];

        for (var i = 0; i < jsonRest.length; i++) {
          ownedRestaurants.add(OwnedRestaurantModel.fromJson(jsonRest[i]));
        }
        yield ReadyOwnedRestaurants(restaurants: ownedRestaurants);
      } else {
        yield FailedLoadingOwnedRestaurants(message: response.toString());
      }
    } else if (event is UpdateOwnedRestaurant) {
      yield UpdatingOwnedRestaurant();
      var model = jsonDecode(jsonEncode(event.restaurantModel));

      if(!hasValidUrl(event.restaurantModel.web)){
        String errorMessage =
            "La URL de la página web es incorrecta, debe contener http:// ó https://";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
        yield FailedUpdatingOwnedRestaurant(message: errorMessage);
        return;

      }
      model["imageFile"] = event.base64Logo;
      model["menu_file"] = event.base64MenuFile;
      var data = model;
      var response = await postService(
          data, '/restaurant/${event.restaurantModel.id}/edit', "");
      if (response['code'] != 200) {
        print("Hubo un error para actualizar el restaurante");
        var errorResponse = jsonDecode(response['message']);
        String finalErrorMessage = "";
        if (!errorResponse.isEmpty) {
          for (var errorElement in errorResponse) {
            finalErrorMessage += errorElement['message'].toString() + ", ";
          }

          if (finalErrorMessage.length >= 2) {
            finalErrorMessage =
                finalErrorMessage.substring(0, finalErrorMessage.length - 2);
          }
        }

        print(finalErrorMessage);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(finalErrorMessage),
        ));

        yield FailedUpdatingOwnedRestaurant(message: finalErrorMessage);
      } else {
        print("Readyy: ");
        print(response);
        yield ReadyUpdatingOwnedRestaurant();
      }
    } else if (event is CreateRestaurant) {
      yield CreatingRestaurant();
      var model = jsonDecode(jsonEncode(event.restaurantModel));
      model["imageFile"] = event.base64Logo;
      model["menu_file"] = event.base64MenuFile;
      var data = model;
      var response = await postService(data, '/restaurant/create', "");
      if (response['code'] >= 200 && response['code'] < 300) {
        yield DoneCreatingRestaurant();
      } else {
        var error = jsonDecode(response['message']);
        yield FailedUpdatingOwnedRestaurant(
            message: error['message'].toString());
      }
    }
  }
}
