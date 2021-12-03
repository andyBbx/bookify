import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'single_thread_event.dart';
part 'single_thread_state.dart';

class SingleThreadBloc extends Bloc<SingleThreadEvent, SingleThreadState> {
  SingleThreadBloc() : super(SingleThreadInitial());

  @override
  Stream<SingleThreadState> mapEventToState(SingleThreadEvent event) async* {
    if(event is StartSingleThreadAction){
      yield SingleThreadActionInProcess();
    } else if(event is SingleThreadActionSuccessfullyCompleted) {

    }
  }
}
