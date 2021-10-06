import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/logics/cubit/signup_cubit.dart';
import 'package:bookify/presentation/screens/auth_screen/login/login_screen.dart';
import 'package:bookify/presentation/screens/home/home_screen.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  Userr userr = Userr();
  final _formKey = new GlobalKey<FormState>();

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
                      onChanged: (val) {
                        userr.username = val;
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
                      onChanged: (val) {
                        userr.secondname = val;
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
                      onChanged: (val) {
                        userr.secondname = val;
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
                  SizedBox(
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
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  SizedBox(
                    width: widht / 1.5,
                    child: TextFormField(
                      onChanged: (val) {
                        userr.email = val;
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
                      onChanged: (val) {
                        userr.location?.adresss = val;
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
                        hintText: "Ubicación",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/location.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                      print(state.toString());
                      if (state is SignupSuccess) {
                        Navigator.pushNamed(context, "/home");
                      }
                      if (state is SignupFaield) {
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
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              width: widht / 1.5,
                              child: LargeButton(
                                text: "Registrarme",
                                isWhite: false,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<SignupCubit>(context)
                                        .signup(userr);

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
