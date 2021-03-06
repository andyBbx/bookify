import 'package:bookify/logics/cubit/signup_cubit.dart';
import 'package:bookify/constants/route.dart';
import 'package:bookify/presentation/screens/auth_screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'presentation/screens/auth_screen/login/auth_repository.dart';
import 'presentation/screens/splash_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    initializeDateFormatting('es_ES').then((value) {
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: MaterialApp(
        title: 'bookify',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (_routeSettings) => appRouteGaneragte(_routeSettings),
        theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'poppins'),
        // initialRoute: "/managerView",
        home: SplashScreen(),
      ),
    );
  }
}
