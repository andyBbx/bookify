import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'micuenta_event.dart';
part 'micuenta_state.dart';

class MicuentaBloc extends Bloc<MicuentaEvent, MicuentaState> {
  MicuentaBloc() : super(MicuentaInitial()) {
    on<MicuentaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
