import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final context;

  RestaurantBloc(this.context) : super(RestaurantInitial());

  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    final currentState = state;

    if (event is LoadData) {
      var response = RestaurantData.fromMocked();
      yield RestaurantLoaded(restaurants: response);
    }
  }
}
