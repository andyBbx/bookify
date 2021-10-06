part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {
  Userr? userr;
  SignupInitial({
    this.userr,
  });
}

class SignupSugmitted extends SignupState {
  Userr? userr;
  SignupSugmitted({
    this.userr,
  });
}

class SignupFaield extends SignupState {
  Exception? exception;
  String? message;

  SignupFaield({
    this.exception,
    this.message,
  });
}

class SignupSuccess extends SignupState {}

class SignupSubmiting extends SignupState {
  Userr? userr;
  SignupSubmiting({
    this.userr,
  });
}
