import 'package:bloc/bloc.dart';
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
    if (event is LoadCurrentRestaurantData) {}
  }
}
