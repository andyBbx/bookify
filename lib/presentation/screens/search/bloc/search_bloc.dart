import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/location.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final context;

  SearchBloc(this.context) : super(SearchInit());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    final currentState = state;

    if (event is SearchLoadEvent) {
      yield SearchLoading();
      List<RestaurantModel> myRestCat = [];

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
        url = '/restaurant?filter[status]=1&filter[name]=${event.searchStr}';
      } else {
        url = '/restaurant?&filter[name]=${event.searchStr}&filter[status]=1&filter[latitude]=${location.lat}&filter[longitude]=${location.long}';
      }

      /* String url =
          '/restaurant?filter[status]=1&filter[name]=${event.searchStr}'; */

      var response = await getService(url, event.user.auth_key!);
      if (response['code'] == 401) {
        yield SearchError(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        for (var i = 0; i < jsonRest.length; i++) {
          var restModel = RestaurantModel.fromJson(jsonRest[i]);
          myRestCat.add(restModel);
        }
        if (myRestCat.isEmpty) {
          yield SearchEmpty();
        } else {
          yield SearchLoad(rest: myRestCat);
        }
      }
    } else if (state is SearchInitEvent) {
      yield SearchInit();
    }
  }
}
