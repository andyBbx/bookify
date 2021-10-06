import 'package:bloc/bloc.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthRep? _authRep;

  SignupCubit() : super(SignupInitial(userr: Userr())) {
    _authRep = AuthRep();
  }

  void signup(Userr user) async {
    submitting(user);
    var response = await _authRep!.Signup(user);
    if (user.email!.startsWith("vovo")) {
      faield(Exception(), "This email adress is already registered");
    } else {
      success();
    }

    // if (response["code"] == 200) {
    //   success();
    // } else {
    //   faield(Exception(), "Not a valid hosting id");
    // }
  }

  void submitting(Userr user) => emit(SignupSubmiting(userr: user));
  void faield(Exception e, String msg) =>
      emit(SignupFaield(exception: e, message: msg));
  void success() => emit(SignupSuccess());
}
