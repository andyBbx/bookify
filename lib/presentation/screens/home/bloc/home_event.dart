part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends HomeEvent {
  const LoadData({required this.user});
  final User user;
  @override
  List<Object> get props => [user];
}

class LoadReservationData extends HomeEvent {
  const LoadReservationData({required this.user});
  final User user;
  @override
  List<Object> get props => [user];
}

class AddFavorite extends HomeEvent {
  const AddFavorite({required this.restId, required this.user});
  final String restId;
  final User user;

  @override
  List<Object> get props => [restId, user];
}

class RemoveFavorite extends HomeEvent {
  const RemoveFavorite({required this.restId, required this.user});
  final String restId;
  final User user;

  @override
  List<Object> get props => [restId, user];
}

class GetRestbyCategory extends HomeEvent {
  const GetRestbyCategory(
      {required this.catId, required this.user, required this.nowActive});
  final String catId;
  final User user;
  final bool nowActive;

  @override
  List<Object> get props => [catId, user, nowActive];
}

class EditReservation extends HomeEvent {
  const EditReservation({required this.reservationModel, required this.user});
  final ReservationModel reservationModel;
  final User user;

  @override
  List<Object> get props => [reservationModel, user];
}

class EditCuenta extends HomeEvent {
  const EditCuenta({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class LoadEstadoRest extends HomeEvent {
  const LoadEstadoRest({required this.user, required this.nowActive});
  final User user;
  final bool nowActive;

  @override
  List<Object> get props => [user, nowActive];
}
