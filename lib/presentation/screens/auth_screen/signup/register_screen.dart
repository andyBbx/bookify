import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/logics/cubit/signup_cubit.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottom_design(isLandccape: isLandccape),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                // padding: EdgeInsets.only(top: 50, left: 20, right: 20),

                decoration: BoxDecoration(
                  color: splash_Logo,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      logo(widht: widht),
                      SizedBox(
                        height: height / 20,
                      ),
                      text1(),
                      SizedBox(
                        height: height / 20,
                      ),
                      SizedBox(
                        width: widht / 1.5,
                        child: TextFormField(
                          onChanged: (val) {
                            userr.username = val;
                          },
                          validator: (val) =>
                              val.toString().length > 3 ? null : "Not a valid ",
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
                          validator: (val) =>
                              val.toString().length > 3 ? null : "Not a valid ",
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
                            hintText: "Segundo apellido",
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
                          validator: (val) =>
                              val.toString().length > 3 ? null : "Not a name",
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
                            hintText: "Segundo apellido",
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
                              : "Not a valid phone ",
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
                              : "Not a valid email",
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
                              : "Not a valid location",
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
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
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
      "Nombre(s)",
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

class bottom_design extends StatelessWidget {
  const bottom_design({
    Key? key,
    required this.isLandccape,
  }) : super(key: key);

  final bool isLandccape;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        !isLandccape
            ? "assets/images/pre_login_bottom_frame.png"
            : "assets/images/pre_login_bottom_frame.png",
        color: frameColor,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
