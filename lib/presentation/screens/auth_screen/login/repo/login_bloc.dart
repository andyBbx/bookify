import 'package:bookify/constants/utils.dart';
import 'package:bookify/presentation/screens/auth_screen/login/repo/form_submission_status.dart';
import 'package:bookify/presentation/screens/auth_screen/login/repo/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_repository.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.login(state.username, state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e, e.toString()));
      }
    }
  }
}
