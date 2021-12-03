import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/table.dart';
import 'package:bookify/data/models/user.dart';
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

      var response = await getService(
          '/table?filter[restaurant_id]=' + event.restaurantId, '');
      if (response['code'] == 401) {
        yield FailedLoadingRestaurantTables(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<TableModel> myRest = [];

        for (var i = 0; i < jsonRest.length; i++) {
          myRest.add(TableModel.fromJson(jsonRest[i]));
        }
        print(jsonEncode(myRest));
        yield ReadyRestaurantTables(tables: myRest);
      } else {
        yield FailedLoadingRestaurantTables(message: response.toString());
      }
    }
  }
}
