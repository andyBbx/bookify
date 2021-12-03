part of 'single_thread_bloc.dart';

abstract class SingleThreadState extends Equatable {
  const SingleThreadState();

  @override
  List<Object> get props => [];
}

class SingleThreadInitial extends SingleThreadState {}
class SingleThreadActionInProcess extends SingleThreadState {}
class SingleThreadActionSuccessfullyCompleted extends SingleThreadState {}
class SingleThreadActionFailed extends SingleThreadState {
  final String message;

  const SingleThreadActionFailed({required this.message});

  @override
  List<Object> get props => [message];
}
