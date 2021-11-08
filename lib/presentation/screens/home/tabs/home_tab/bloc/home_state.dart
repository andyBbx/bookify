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

class HomeLoaded extends HomeState {
  const HomeLoaded({required this.categories});

  final dynamic categories;

  @override
  List<Object> get props => [categories];
}

class HomeFail extends HomeState {
  const HomeFail({required this.message});

  final dynamic message;

  @override
  List<Object> get props => [message];
}
