part of 'single_thread_bloc.dart';

abstract class SingleThreadEvent extends Equatable {
  const SingleThreadEvent();

  @override
  List<Object> get props => [];
}

class StartSingleThreadAction extends SingleThreadEvent{}
