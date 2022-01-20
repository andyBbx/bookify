import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/category.dart';
import 'package:bookify/data/models/location.dart';
import 'package:bookify/data/models/offer.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

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
      yield HomeLoading();
      List<CategoryModel> myCat = [];
      List<RestaurantModel> myRestFav = [];
      List<RestaurantModel> myRest = [];
      List<RestaurantModel> myRestCat = [];
      List<ReservationModel> myReservations = [];
      List<OfferModel> myOffers = [];

      // load offers

      var response =
          await getService('/ad?filter[status]=1', event.user.auth_key!);
      if (response['code'] == 401) {
        yield HomeFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        for (var i = 0; i < jsonRest.length; i++) {
          var restModel = OfferModel.fromJson(jsonRest[i]);
          myOffers.add(restModel);
        }

        // yield HomeLoadOffers(offers: myOffers);
      }

      // load categories
      var responseCat = await getService('/tag?filter[status]=1', '');
      if (responseCat['code'] == 401) {
        yield HomeFail(message: responseCat['message']);
      } else if (responseCat['code'] == 200) {
        var jsonRest = jsonDecode(responseCat['model']);

        if (myOffers.isNotEmpty) {
          myCat.add(CategoryModel(
              createdAt: DateTime.now(),
              id: '',
              image: '',
              status: 1,
              name: 'Ofertas',
              updatedAt: DateTime.now()));
        }

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
        var responseFav = await getService(
            '/restaurant?filter[status]=1', event.user.auth_key!);
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
          // load con cualquier momento

          var datenow = DateFormat('yyyy-MM-dd').format(DateTime.now());
          var timenow = DateFormat('kk:mm:ss').format(DateTime.now());

          String? locationModel;
          Location location = Location();
          await Utils().startSharedPreferences().then((prefs) {
            locationModel = prefs.getString("location");
          });
          if (Utils().checkJsonArray(locationModel)) {
            location = location.fromJson(jsonDecode(locationModel!));
          } else {
            await setLocation();
            await Utils().startSharedPreferences().then((prefs) {
              locationModel = prefs.getString("location");
            });
            if (Utils().checkJsonArray(locationModel)) {
              location = location.fromJson(jsonDecode(locationModel!));
            }
          }

          String url;
          if (location.lat != null && location.long != null) {
            url =
                '/restaurant?filter[status]=1&filter[latitude]=${location.lat}&filter[longitude]=${location.long}';
          } else {
            url = '/restaurant?filter[status]=1';
          }

          var responseRest = await getService(url, event.user.auth_key!);
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

              // // load offers

              // var response = await getService(
              //     '/ad?filter[status]=1', event.user.auth_key!);
              // if (response['code'] == 401) {
              //   yield HomeFail(message: response['message']);
              // } else if (response['code'] == 200) {
              //   var jsonRest = jsonDecode(response['model']);
              //   for (var i = 0; i < jsonRest.length; i++) {
              //     var restModel = OfferModel.fromJson(jsonRest[i]);
              //     myOffers.add(restModel);
              //   }

              //   yield HomeLoadOffers(offers: myOffers);
              yield HomeLoadOffers(offers: myOffers);
              // }
            }
          }
        }
      }
      yield HomeLoadInit(
          rest: myRest,
          categories: myCat,
          restFav: myRestFav,
          reservations: myReservations,
          offers: myOffers);
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
        var responseFav = await getService(
            '/restaurant?filter[status]=1', event.user.auth_key!);
        if (responseFav['code'] == 401) {
          yield HomeFail(message: responseFav['message']);
        } else if (responseFav['code'] == 200) {
          var jsonRest = jsonDecode(responseFav['model']);

          // for (var i = 0; i < jsonRest.length; i++) {
          //   var restModel = RestaurantModel.fromJson(jsonRest[i]);
          //   if (restModel.favorite == 1) {
          //     myRestFav.add(restModel);
          //   }
          // }
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
        // yield HomeLoadFavorites(restFav: myRestFav, rest: myRest);
        var responseFav = await getService(
            '/restaurant?filter[status]=1', event.user.auth_key!);
        if (responseFav['code'] == 401) {
          yield HomeFail(message: responseFav['message']);
        } else if (responseFav['code'] == 200) {
          var jsonRest = jsonDecode(responseFav['model']);

          // for (var i = 0; i < jsonRest.length; i++) {
          //   var restModel = RestaurantModel.fromJson(jsonRest[i]);
          //   if (restModel.favorite == 1) {
          //     myRestFav.add(restModel);
          //   }
          // }
          for (var i = 0; i < jsonRest.length; i++) {
            var restModel = RestaurantModel.fromJson(jsonRest[i]);
            myRest.add(restModel);
          }

          yield HomeLoadFavorites(restFav: myRestFav, rest: myRest);
        }
      }
    } else if (event is GetRestbyCategory) {
      yield HomeCategoryLoading();
      List<RestaurantModel> myRestCat = [];

      var dateTime = event.nowActive ? DateTime.now() : null;
      var data = {"restaurant_id": event.catId};

      // TODO: verficiar con productos reales

      Location location = Location();
      String? locationModel;
      await Utils().startSharedPreferences().then((prefs) {
        locationModel = prefs.getString("location");
      });

      if (Utils().checkJsonArray(locationModel)) {
        location = location.fromJson(jsonDecode(locationModel!));
      }

      String url;
      if (location.lat == null || location.long == null) {
        url = event.nowActive
            ? '/restaurant?filter[tag_id]=${event.catId}&filter[time]=$dateTime&filter[date]=$dateTime&filter[status]=1'
            : '/restaurant?filter[tag_id]=${event.catId}&filter[status]=1';
      } else {
        url = event.nowActive
            ? '/restaurant?filter[tag_id]=${event.catId}&filter[time]=$dateTime&filter[date]=$dateTime&filter[status]=1&filter[latitude]=${location.lat}&filter[longitude]=${location.long}'
            : '/restaurant?filter[tag_id]=${event.catId}&filter[status]=1&filter[latitude]=${location.lat}&filter[longitude]=${location.long}';
      }

      var response = await getService(url, event.user.auth_key!);
      if (response['code'] == 401) {
        yield HomeFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        for (var i = 0; i < jsonRest.length; i++) {
          var restModel = RestaurantModel.fromJson(jsonRest[i]);
          myRestCat.add(restModel);
        }

        var responseFav = await getService(
            '/restaurant?filter[status]=1', event.user.auth_key!);
        if (responseFav['code'] == 401) {
          yield HomeFail(message: responseFav['message']);
        } else if (responseFav['code'] == 200) {
          var jsonRest = jsonDecode(responseFav['model']);

          // for (var i = 0; i < jsonRest.length; i++) {
          //   var restModel = RestaurantModel.fromJson(jsonRest[i]);
          //   if (restModel.favorite == 1) {
          //     myRestFav.add(restModel);
          //   }
          // }
          // ff(jsonRest.lenght > 0) {

          // }
          // var restModel = RestaurantModel.fromJson(jsonRest[0]);
          // myRestCat.add(restModel);
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
    } else if (event is EditReservation) {
      yield HomeEditResLoading();
      List<RestaurantModel> myRest = [];
      List<ReservationModel> myReservations = [];
      var data = {
        "client_id": event.reservationModel.clientId,
        "id": event.reservationModel.id,
        "restaurant_id": event.reservationModel.restaurantData["id"],
        "quantity": event.reservationModel.quantity,
        "time": event.reservationModel.time,
        "date": event.reservationModel.date.toString(),
        "rated": event.reservationModel.rated,
        "status": event.reservationModel.status,
      };
      var responsResv = await postService(
          data,
          '/solicitude/${event.reservationModel.id}/edit',
          event.user.auth_key!);

      if (responsResv['code'] == 401) {
        yield HomeFail(message: responsResv['message']);
      } else if (responsResv['code'] == 200) {
        // load restaurants
        // TODO: cargar restaurantes "ahora"

        Location location = Location();
        String? locationModel = prefs.getString("location");
        if (Utils().checkJsonArray(locationModel)) {
          location = location.fromJson(jsonDecode(locationModel!));
        }

        String url;
        if (location.lat == null || location.long == null) {
          url = '/restaurant?filter[status]=1';
        } else {
          url =
              '/restaurant?filter[status]=1&filter[latitude]=${location.lat}&filter[longitude]=${location.long}';
        }

        var responseRest = await getService(url, event.user.auth_key!);
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
      yield HomeEditResLoad(rest: myRest, resv: myReservations);
    } else if (event is EditCuenta) {
      yield EditUserLoading();

      try {
        var data = {
          "firstname": event.user.firstname,
          "middlename": event.user.middlename,
          "lastname": event.user.lastname,
          "email": event.user.email,
          "phone": event.user.phone,
          "imageFile": event.user.avatar,
        };

        var response =
            await postService(data, '/user/profile-edit', event.user.auth_key!);
        if (response['code'] != 200) {
          yield EditUserFail(message: response['message']);
        } else if (response['code'] == 200) {
          var jsonRest = jsonDecode(response['model']);
          jsonRest['auth_key'] = event.user.auth_key;
          saveUserModel(jsonEncode(jsonRest));
          yield EditUserLoad();
        }
      } catch (e) {
        yield EditUserFail(message: e.toString());
      }
    } else if (event is EditPasswordInit) {
      yield EditPasswordInitState();
    } else if (event is EditPassword) {
      yield EditPasswordLoading();

      try {
        var dataLogin = {
          "email": event.user.email,
          "password": event.user.password
        };
        var responseLogin = await postService(dataLogin, '/user/login', "");
        if (responseLogin['code'] != 200) {
          var error = jsonDecode(responseLogin['message']);
          yield EditPasswordFail(message: error['message']);
        } else {
          var data = {
            "password": event.newPassword,
          };

          var response = await postService(
              data, '/user/profile-edit', event.user.auth_key!);
          if (response['code'] != 200) {
            var error = jsonDecode(responseLogin['message']);
            yield EditPasswordFail(message: error['message']);
          } else if (response['code'] == 200) {
            var jsonRest = jsonDecode(response['model']);
            jsonRest['auth_key'] = event.user.auth_key;
            saveUserModel(jsonEncode(jsonRest));
            yield EditPasswordLoad();
          }
        }
      } catch (e) {
        yield EditUserFail(message: e.toString());
      }
    } else if (event is LoadEstadoRest) {
      yield EstadoRestLoading();
      List<RestaurantModel> myRestCat = [];

      var datenow = DateFormat('yyyy-MM-dd').format(DateTime.now());
      var timenow = DateFormat('kk:mm:ss').format(DateTime.now());

      Location location = Location();
      String? locationModel;
      await Utils().startSharedPreferences().then((prefs) {
        locationModel = prefs.getString("location");
      });

      if (Utils().checkJsonArray(locationModel)) {
        location = location.fromJson(jsonDecode(locationModel!));
      }
      String url;
      if (location.lat == null || location.long == null) {
        url = event.nowActive
            ? '/restaurant?filter[status]=1'
            : '/restaurant?filter[time]=$timenow&filter[date]=$datenow&filter[status]=1';
      } else {
        url = event.nowActive
            ? '/restaurant?filter[status]=1&filter[latitude]=${location.lat}&filter[longitude]=${location.long}'
            : '/restaurant?filter[time]=$timenow&filter[date]=$datenow&filter[status]=1&filter[latitude]=${location.lat}&filter[longitude]=${location.long}';
      }

      var response = await getService(url, event.user.auth_key!);
      if (response['code'] == 401) {
        yield HomeFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        for (var i = 0; i < jsonRest.length; i++) {
          var restModel = RestaurantModel.fromJson(jsonRest[i]);
          myRestCat.add(restModel);
        }
        yield EstadoRestLoad(rest: myRestCat);
      }
    } else if (event is GetOffers) {
      yield HomeCategoryLoading();
      List<OfferModel> myOffers = [];

      var response =
          await getService('/ad?filter[status]=1', event.user.auth_key!);
      if (response['code'] == 401) {
        yield HomeFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        for (var i = 0; i < jsonRest.length; i++) {
          var restModel = OfferModel.fromJson(jsonRest[i]);
          myOffers.add(restModel);
        }
        yield HomeLoadOffers(offers: myOffers);
      }
    }
  }
}
