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

class HomeLoadFavorites extends HomeState {
  const HomeLoadFavorites({
    required this.restFav,
  });

  final dynamic restFav;

  @override
  List<Object> get props => [restFav];
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
