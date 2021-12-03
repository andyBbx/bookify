import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/table.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableBloc() : super(TableInitial());

  @override
  Stream<TableState> mapEventToState(TableEvent event) async* {
    if (event is CreateTable) {
      yield CreatingTable();
      var model = jsonDecode(jsonEncode(event.table));
      model["id"] = null;
      var data = model;
      var response = await postService(data, '/table/create', "");
      if (response['code'] >= 200 && response['code'] < 300) {
        yield DoneCreatingTable();
      } else {
        print("Hubo un error para crear la mesa");
        /* var error = jsonDecode(response['message']); */
        yield FailedCreatingTable(message: response['message'].toString());
      }
    } else if (event is SwapTable) {
      yield SwappingTable();
      var data = {
        "from_table_id": event.originTableId,
        "from_solicitude_id": event.originBookingId,
        "to_table_id": event.destinationTableId,
        "to_solicitude_id": event.destinationBookingId
      };
      var response = await postService(data, '/table/swap-table', "");
      if (Utils().successfulHTTPCode(response['code'])) {
        yield DoneSwappingTable();
      } else {
        yield FailedSwappingTable(message: response['message']);
      }
    } else if (event is ResetTableInstance) {
      yield TableInitial();
    }
  }
}
