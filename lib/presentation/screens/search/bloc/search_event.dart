part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitEvent extends SearchEvent {
  @override
  List<Object> get props => [];
}

class SearchLoadEvent extends SearchEvent {
  const SearchLoadEvent({required this.searchStr, required this.user});
  final String searchStr;
  final User user;

  @override
  List<Object> get props => [searchStr, user];
}
