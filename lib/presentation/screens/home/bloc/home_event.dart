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
  const GetRestbyCategory({required this.catId, required this.user});
  final String catId;
  final User user;

  @override
  List<Object> get props => [catId, user];
}
