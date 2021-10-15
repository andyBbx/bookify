import '../../../../../data/models/user.dart';
import 'package:flutter/material.dart';

import 'form_submission_status.dart';

class SignUpState {
  final User user;
  final FormSubmissionStatus formStatus;

  SignUpState({required this.user, required this.formStatus});

  bool get isValidemail => user.email!.contains("@");

  bool get isValidPassword => user.password!.length > 6;

  SignUpState copyWith({User? user, FormSubmissionStatus? formStatus1}) {
    return SignUpState(
        formStatus: formStatus1 ?? this.formStatus, user: user ?? this.user);
  }
}
