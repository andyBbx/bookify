import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/category.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final context;

  HomeBloc(this.context) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    final currentState = state;

    if (event is LoadData) {
      List<CategoryModel> myCat = [];
      List<RestaurantModel> myRestFav = [];
      List<RestaurantModel> myRest = [];
      List<ReservationModel> myReservations = [];
      // load categories
      var responseCat = await getService('/tag', '');
      if (responseCat['code'] == 401) {
        yield HomeFail(message: responseCat['message']);
      } else if (responseCat['code'] == 200) {
        var jsonRest = jsonDecode(responseCat['model']);

        myCat.add(CategoryModel(
            createdAt: DateTime.now(),
            id: '',
            image: '',
            status: 1,
            name: 'De todo',
            updatedAt: DateTime.now()));

        for (var i = 0; i < jsonRest.length; i++) {
          myCat.add(CategoryModel.fromJson(jsonRest[i]));
        }
        // load favorites
        var responseFav = await getService('/restaurant', event.user.auth_key!);
        if (responseFav['code'] == 401) {
          yield HomeFail(message: responseFav['message']);
        } else if (responseFav['code'] == 200) {
          var jsonRest = jsonDecode(responseFav['model']);

          for (var i = 0; i < jsonRest.length; i++) {
            var restModel = RestaurantModel.fromJson(jsonRest[i]);
            if (restModel.favorite == 1) {
              myRestFav.add(restModel);
            }
          }
          // load restaurants
          // TODO: cargar restaurantes "ahora"
          var responseRest =
              await getService('/restaurant', event.user.auth_key!);
          if (responseRest['code'] == 401) {
            yield HomeFail(message: responseRest['message']);
          } else if (responseRest['code'] == 200) {
            var jsonRest = jsonDecode(responseRest['model']);

            for (var i = 0; i < jsonRest.length; i++) {
              var restModel = RestaurantModel.fromJson(jsonRest[i]);
              myRest.add(restModel);
            }

            // load reservations
            var responseReservation =
                await getService('/solicitude', event.user.auth_key!);
            if (responseReservation['code'] == 401) {
              yield HomeFail(message: responseReservation['message']);
            } else if (responseReservation['code'] == 200) {
              var jsonRest = jsonDecode(responseReservation['model']);

              for (var i = 0; i < jsonRest.length; i++) {
                var reservationModel = ReservationModel.fromJson(jsonRest[i]);
                myReservations.add(reservationModel);
              }
            }
          }
        }
      }
      yield HomeLoadInit(
          rest: myRest,
          categories: myCat,
          restFav: myRestFav,
          reservations: myReservations);
    } else if (event is AddFavorite) {
      List<RestaurantModel> myRestFav = [];
      List<RestaurantModel> myRest = [];
      var data = {"restaurant_id": event.restId};
      var response = await getService(
          '/user/add-favorite-restaurant?id=${event.restId}',
          event.user.auth_key!);
      if (response['code'] == 401) {
        yield HomeFail(message: response['message']);
      } else if (response['code'] == 200) {
        var responseFav = await getService('/restaurant', event.user.auth_key!);
        if (responseFav['code'] == 401) {
          yield HomeFail(message: responseFav['message']);
        } else if (responseFav['code'] == 200) {
          var jsonRest = jsonDecode(responseFav['model']);

          for (var i = 0; i < jsonRest.length; i++) {
            var restModel = RestaurantModel.fromJson(jsonRest[i]);
            if (restModel.favorite == 1) {
              myRestFav.add(restModel);
            }
          }
          for (var i = 0; i < jsonRest.length; i++) {
            var restModel = RestaurantModel.fromJson(jsonRest[i]);
            myRest.add(restModel);
          }

          yield HomeLoadFavorites(restFav: myRestFav, rest: myRest);
        }
      }
    } else if (event is RemoveFavorite) {
      List<RestaurantModel> myRestFav = [];
      List<RestaurantModel> myRest = [];
      var data = {"restaurant_id": event.restId};
      var response = await getService(
          '/user/delete-favorite-restaurant?id=${event.restId}',
          event.user.auth_key!);
      if (response['code'] == 401) {
        yield HomeFail(message: response['message']);
      } else if (response['code'] == 200) {
        var responseFav = await getService('/restaurant', event.user.auth_key!);
        if (responseFav['code'] == 401) {
          yield HomeFail(message: responseFav['message']);
        } else if (responseFav['code'] == 200) {
          var jsonRest = jsonDecode(responseFav['model']);

          for (var i = 0; i < jsonRest.length; i++) {
            var restModel = RestaurantModel.fromJson(jsonRest[i]);
            if (restModel.favorite == 1) {
              myRestFav.add(restModel);
            }
          }
          for (var i = 0; i < jsonRest.length; i++) {
            var restModel = RestaurantModel.fromJson(jsonRest[i]);
            myRest.add(restModel);
          }

          yield HomeLoadFavorites(restFav: myRestFav, rest: myRest);
        }
      }
    } else if (event is GetRestbyCategory) {
      // yield LoadRest();
      List<RestaurantModel> myRestCat = [];
      var data = {"restaurant_id": event.catId};
      var response = await getService(
          '/restaurant?filter[tag_id]=${event.catId}', event.user.auth_key!);
      if (response['code'] == 401) {
        yield HomeFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        for (var i = 0; i < jsonRest.length; i++) {
          var restModel = RestaurantModel.fromJson(jsonRest[i]);
          myRestCat.add(restModel);
        }
        yield HomeLoadRest(rest: myRestCat);
      }
    } else if (event is LoadReservationData) {
      List<ReservationModel> myReservations = [];

      // load reservations
      var responseReservation =
          await getService('/solicitude', event.user.auth_key!);
      if (responseReservation['code'] == 401) {
        yield HomeFail(message: responseReservation['message']);
      } else if (responseReservation['code'] == 200) {
        var jsonRest = jsonDecode(responseReservation['model']);

        for (var i = 0; i < jsonRest.length; i++) {
          var reservationModel = ReservationModel.fromJson(jsonRest[i]);
          myReservations.add(reservationModel);
        }
      }

      yield HomeLoadReservation(reservations: myReservations);
    }
  }
}
