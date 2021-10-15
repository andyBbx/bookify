import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthRep? _authRep;

  SignupCubit() : super(SignupInitial(userr: User())) {
    _authRep = AuthRep();
  }

  late SharedPreferences prefs;

  Future startSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void signup(User user) async {
    submitting(user);
    var response = await _authRep!.Signup(user);
    if (response["code"] != 200) {
      failed(Exception(), response["message"]);
    } else {
      startSharedPreferences().then((value) {
        prefs.setString("user", response["model"]);
        String? userModelString = prefs.getString("user");
        if (Utils().checkJsonArray(userModelString)) {
          User newuser = User();
          newuser = newuser.fromJson(jsonDecode(userModelString!));
          /* print("M: " + response["model"]);
          print("X: " + userModelString);
          print("Hey you: " + jsonEncode(newuser)); */
          if ((newuser.id)!.isNotEmpty) {
            success();
          }
        }
      });
    }
  }

  void submitting(User user) => emit(SignupSubmiting(userr: user));
  void failed(Exception e, String msg) =>
      emit(SignupFailed(exception: e, message: msg));
  void success() => emit(SignupSuccess());
}
