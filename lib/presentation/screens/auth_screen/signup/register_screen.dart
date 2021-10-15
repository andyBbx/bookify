import 'dart:convert';

import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/logics/cubit/signup_cubit.dart';
import 'package:bookify/presentation/screens/auth_screen/login/login_screen.dart';
import 'package:bookify/presentation/screens/home/home_screen.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  User user = User();
  final _formKey = new GlobalKey<FormState>();

  /* bool isManager = false;
  String name = "";
  String firstLastname = "";
  String secondLastName = "";
  String mail = "";
  String password = ""; */

  @override
  void initState() {
    // TODO: implement initState
    Utils().startSharedPreferences();
    user.firstname = "Test";
    user.middlename = "Test";
    user.lastname = "Test";
    user.email = "test@gmail.com";
    user.password = "12345678";
    user.isManager = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  image: AssetImage(
                    !isLandccape
                        ? "assets/halfPattern.png"
                        : "assets/halfPattern.png",
                  )),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.only(
                    left: widht / 8, right: widht / 8, top: 120, bottom: 60),
                children: [
                  // const SizedBox(
                  //   height: 100,
                  // ),
                  // logo(widht: widht),
                  // SizedBox(
                  //   height: height / 20,
                  // ),
                  const text1(),
                  SizedBox(
                    height: height / 20,
                  ),
                  SizedBox(
                    width: widht / 1.5,
                    child: TextFormField(
                      initialValue: user.firstname,
                      onChanged: (val) {
                        user.firstname = val;
                      },
                      validator: (val) => val.toString().length > 3
                          ? null
                          : "Este campo es requerido",
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        hintText: "Nombre(s)",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  SizedBox(
                    width: widht / 1.5,
                    child: TextFormField(
                      initialValue: user.middlename,
                      onChanged: (val) {
                        user.middlename = val;
                      },
                      validator: (val) => val.toString().length > 3
                          ? null
                          : "Este campo es requerido",
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        hintText: "Primer apellido",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  SizedBox(
                    width: widht / 1.5,
                    child: TextFormField(
                      initialValue: user.lastname,
                      onChanged: (val) {
                        user.lastname = val;
                      },
                      // validator: (val) => val.toString().length > 3
                      //     ? null
                      //     : "Este campo es requerido",
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        hintText: "Segundo apellido (opcional)",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  /* SizedBox(
                    width: widht / 1.5,
                    child: TextFormField(
                      onChanged: (val) {
                        userr.phone = val;
                      },
                      keyboardType: TextInputType.phone,
                      validator: (val) => val.toString().length > 3
                          ? null
                          : "Este campo es requerido",
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        hintText: "Teléfono ",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/phone.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ), */
                  SizedBox(
                    width: widht / 1.5,
                    child: TextFormField(
                      initialValue: user.email,
                      onChanged: (val) {
                        user.email = val;
                      },
                      validator: (val) => val.toString().length > 3 &&
                              val.toString().contains("@")
                          ? null
                          : "Este campo es requerido",
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        hintText: "Correo",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/mail.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  SizedBox(
                    width: widht / 1.5,
                    child: TextFormField(
                      initialValue: user.password,
                      onChanged: (val) {
                        user.location?.adresss = val;
                      },
                      obscureText: false,
                      validator: (val) => val.toString().length > 3
                          ? null
                          : "Este campo es requerido",
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        hintText: "Contraseña",
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFFDB7714)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  CheckboxListTile(
                    title: const Text('Quiero registrarme como manager'),
                    value: user.isManager,
                    onChanged: (value) {
                      setState(() {
                        user.isManager = value!;
                      });
                    },
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                      print(state.toString());
                      if (state is SignupSuccess) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/home", (Route route) => false);
                      }
                      if (state is SignupFailed) {
                        // Navigator.popAndPushNamed(context, "\home");
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(state.message!)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is SignupSubmiting?
                          ? Container(
                              width: 50,
                              height: 50,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : SizedBox(
                              width: widht / 1.5,
                              child: LargeButton(
                                text: "Registrarme",
                                isWhite: false,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<SignupCubit>(context)
                                        .signup(user);

                                    // context.Bloc<SignupCubit>.
                                  }
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => HomeScreen()));
                                },
                              ),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "¿Ya tienes cuenta?",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: textDrkgray),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(" Inicia sesión.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textDrkgray)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class text1 extends StatelessWidget {
  const text1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Registro",
      textAlign: TextAlign.center,
      style:
          TextStyle(color: textBold, fontWeight: FontWeight.bold, fontSize: 26),
    );
  }
}

class logo extends StatelessWidget {
  const logo({
    Key? key,
    required this.widht,
  }) : super(key: key);

  final double widht;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/logo_full.svg",
      width: widht / 2,
    );
  }
}
