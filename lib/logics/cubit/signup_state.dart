part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {
  User? userr;
  SignupInitial({
    this.userr,
  });
}

class SignupSugmitted extends SignupState {
  User? userr;
  SignupSugmitted({
    this.userr,
  });
}

class SignupFailed extends SignupState {
  Exception? exception;
  String? message;

  SignupFailed({
    this.exception,
    this.message,
  });
}

class SignupSuccess extends SignupState {
  User? userr;
  SignupSuccess({
    this.userr,
  });
}

class SignupSubmiting extends SignupState {
  User? userr;
  SignupSubmiting({
    this.userr,
  });
}
