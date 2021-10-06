import 'package:bookify/presentation/screens/auth_screen/login/auth_repository.dart';
import 'package:bookify/presentation/screens/auth_screen/signup/repo/signup_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_state.dart';

class SignUpBloc extends Bloc<SignuUpEvents, SignUpState> {
  SignUpBloc(SignUpState initialState) : super(initialState);
  // SignUpBloc(this.authRepository)
  //     : super(SignUpState(user: null, formStatus: null));

  // @override
  // Stream<SignUpState> mapEventToState(SignUpState event) async* {
  //   if (event is SignuUpEventsNameChange) {
  //     yield state.copyWith(
  //         user: state.user,
  //         formStatus1: SignuUpEventsNameChange(state.user.suername));
  //   }
  // }
}
