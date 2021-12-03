import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/booking_requests/booking_requests_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/CurrentRestaurant/bloc/current_restaurant_bloc.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/bloc/owned_restaurants_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Table/bloc/table_bloc.dart';
import 'package:bookify/presentation/screens/Manager/TableBookings/bloc/table_bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/screens/Manager/home.dart';
import 'package:bookify/presentation/screens/auth_screen/signup/register_screen.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/home/home_screen.dart';
import 'package:bookify/presentation/screens/miCuenta/bloc/micuenta_bloc.dart';
import 'package:bookify/presentation/screens/restaurant/bloc/restaurant_bloc.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'auth_repository.dart';
import 'repo/form_submission_status.dart';
import 'repo/login_bloc.dart';
import 'repo/login_event.dart';
import 'repo/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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
            height: 150,
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
              body: BlocProvider(
                  create: (context) => LoginBloc(authRepo: AuthRepository()),
                  child: FormLogin(
                      formKey: _formKey, height: height, widht: widht))),
        ],
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.height,
    required this.widht,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final double height;
  final double widht;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (cc, state1) {
        final statusform = state1.formStatus;
        if (statusform is SubmissionSuccess) {
          if (statusform.isManager) {
            Navigator.pushNamedAndRemoveUntil(
                                context, "/managerView", (Route route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(providers: [
                          BlocProvider(
                            create: (context) => RestaurantBloc(context),
                          ),
                          BlocProvider(
                            create: (context) => HomeBloc(context),
                          ),
                        ], child: const HomeScreen())),
                (route) => false);
          }
        } else if (statusform is SubmissionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(statusform.errorMessage
                .toString()
                .substring(11, statusform.errorMessage.toString().length)),
          ));
        }
      },
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: widht / 8, vertical: 80),
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height / 20,
            ),
            logo(500),
            SizedBox(
              height: height / 14,
            ),
            const Text1(),
            const SizedBox(
              height: 10,
            ),
            email_field(widht: widht),
            SizedBox(
              height: height / 40,
            ),
            pass_fielld(widht: widht),
            SizedBox(
              height: height / 40,
            ),
            LoginButton(widht: widht, formKey: _formKey),
            SizedBox(
              height: height / 40,
            ),
            Text(
              "¿Olvidaste tu contraseña?",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: textDrkgray),
            ),
            SizedBox(
              height: height / 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿Aún no tienes cuenta?",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: textDrkgray),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
                  },
                  child: Text(" Regístrate.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textDrkgray)),
                ),
              ],
            ),
            /* SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿Eres Manager?",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: textDrkgray),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ManagerView()));
                  },
                  child: Text(" Dirígete aquí.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textDrkgray)),
                ),
              ],
            ), */
          ],
        ),
      ),
    );
  }
}

class saveUserModel {}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.widht,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final double widht;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (conect, state) => state.formStatus is FormSubmitting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: widht / 1.2,
              child: LargeButton(
                text: "Iniciar sesión",
                isWhite: false,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                  //
                },
              ),
            ),
    );
  }
}

class pass_fielld extends StatelessWidget {
  const pass_fielld({
    Key? key,
    required this.widht,
  }) : super(key: key);

  final double widht;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (BuildContext, state) {
      return SizedBox(
        width: widht / 1.5,
        child: TextFormField(
          initialValue: context.read<LoginBloc>().state.password,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          validator: (val) =>
              BuildContext.read<LoginBloc>().state.isValidPassword
                  ? null
                  : "Introduce una contraseña vailida",
          onChanged: (val) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: val)),
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
            suffixIcon: SvgPicture.asset(
              "assets/images/icons/lock.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      );
    });
  }
}

class email_field extends StatelessWidget {
  const email_field({
    Key? key,
    required this.widht,
  }) : super(key: key);

  final double widht;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widht / 1.5,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (conect, state) => TextFormField(
          initialValue: context.read<LoginBloc>().state.username,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(username: value));
          },
          validator: (val) => context.read<LoginBloc>().state.isValidUsername
              ? null
              : "Introduce un correo valido",
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
            suffixIcon: SvgPicture.asset(
              "assets/images/icons/profile.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}

class Text1 extends StatelessWidget {
  const Text1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Iniciar Sesión",
      textAlign: TextAlign.center,
      style:
          TextStyle(color: textBold, fontWeight: FontWeight.bold, fontSize: 26),
    );
  }
}
