part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeEmpty extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeEmptyDB extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadRestFav extends HomeState {
  const HomeLoadRestFav({required this.restaurantsFav});

  final dynamic restaurantsFav;

  @override
  List<Object> get props => [restaurantsFav];
}

class HomeLoadInit extends HomeState {
  const HomeLoadInit(
      {required this.rest,
      required this.restFav,
      required this.categories,
      required this.reservations});

  final dynamic rest;
  final dynamic restFav;
  final dynamic categories;
  final dynamic reservations;

  @override
  List<Object> get props => [rest, restFav, categories, reservations];
}

class HomeLoadReservation extends HomeState {
  const HomeLoadReservation({required this.reservations});

  final dynamic reservations;

  @override
  List<Object> get props => [reservations];
}

class HomeLoadFavorites extends HomeState {
  const HomeLoadFavorites({
    required this.restFav,
    required this.rest,
  });

  final dynamic restFav;
  final dynamic rest;
  @override
  List<Object> get props => [restFav, rest];
}

class HomeLoadRest extends HomeState {
  const HomeLoadRest({
    required this.rest,
  });

  final dynamic rest;

  @override
  List<Object> get props => [rest];
}

class LoadRest extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeFail extends HomeState {
  const HomeFail({required this.message});

  final dynamic message;

  @override
  List<Object> get props => [message];
}

class HomeCategoryLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeEditResLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeEditResLoad extends HomeState {
  const HomeEditResLoad({
    required this.rest,
    required this.resv,
  });

  final dynamic resv;
  final dynamic rest;
  @override
  List<Object> get props => [resv, rest];
}

class EditUserLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class EditUserLoad extends HomeState {
  @override
  List<Object> get props => [];
}

class EditUserFail extends HomeState {
  const EditUserFail({required this.message});

  final dynamic message;

  @override
  List<Object> get props => [message];
}
