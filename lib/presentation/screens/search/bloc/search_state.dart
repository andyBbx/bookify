part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInit extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoad extends SearchState {
  const SearchLoad({required this.rest});

  final dynamic rest;

  @override
  List<Object> get props => [rest];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchError extends SearchState {
  const SearchError({required this.message});

  final dynamic message;

  @override
  List<Object> get props => [message];
}
