import 'package:bloc/bloc.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  TablesBloc() : super(TablesInitial());

  @override
  Stream<TablesState> mapEventToState(TablesEvent event) async* {
    if (event is LoadRestaurantTables) {
      yield LoadingRestaurantTables();

      var response =
          await getService('/table', '');
      if (response['code'] == 401) {
        yield FailedLoadingRestaurantTables(message: response['message']);
      } else if (response['code'] == 200) {
        /* var jsonRest = jsonDecode(response['model']);
        List<RestaurantModel> myRest = [];

        for (var i = 0; i < jsonRest.length; i++) {
          myRest.add(RestaurantModel.fromJson(jsonRest[i]));
        }
        yield ReadyOwnedRestaurants(restaurants: myRest); */
      } else {
        /* yield FailedLoadingOwnedRestaurants(message: response.toString()); */
      }
    }
  }
}
