import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/category.dart';
import 'package:bookify/data/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
      var response = await getService('/tag');
      if (response['code'] == 401) {
        yield HomeFail(message: response['message']);
      } else if (response['code'] == 200) {
        var jsonRest = jsonDecode(response['model']);
        List<CategoryModel> myRest = [];

        myRest.add(CategoryModel(
            createdAt: DateTime.now(),
            id: '',
            image: '',
            status: 1,
            name: 'De todo',
            updatedAt: DateTime.now()));

        for (var i = 0; i < jsonRest.length; i++) {
          myRest.add(CategoryModel.fromJson(jsonRest[i]));
        }
        yield HomeLoaded(categories: myRest);
      }
    }
  }
}
