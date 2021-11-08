import 'package:bookify/presentation/screens/Manager/home.dart';
import 'package:bookify/presentation/screens/auth_screen/login/login_screen.dart';
import 'package:bookify/presentation/screens/auth_screen/signup/register_screen.dart';
import 'package:bookify/presentation/screens/home/home_screen.dart';
import 'package:bookify/presentation/screens/home/tabs/mis_reservas_screen.dart';
import 'package:bookify/presentation/screens/pre_login_screen.dart';
import 'package:bookify/presentation/screens/restaurant_info/view/resutrant_selection_screen.dart';
import 'package:bookify/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

Route? appRouteGaneragte(RouteSettings _routeSettings) {
  switch (_routeSettings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => PreLoginScreen());
      break;
    case "/splash":
      return MaterialPageRoute(builder: (context) => SplashScreen());
      break;
    case "/login":
      return MaterialPageRoute(builder: (context) => LoginScreen());
      break;
    case "/signup":
      return MaterialPageRoute(builder: (context) => RegisterScreen());
      break;
    // case "/home":
    //   return MaterialPageRoute(builder: (context) => HomeScreen());
    //   break;
    case "/home":
      return MaterialPageRoute(builder: (context) => HomeScreen());
      break;
    case "/reservation":
      return MaterialPageRoute(builder: (context) => MisReservasScreen());
      break;
    case "/managerView":
      return MaterialPageRoute(builder: (context) => ManagerView());
      break;
      // case "/resuturant_details":
      //   return MaterialPageRoute(
      //       builder: (context) => const ResturantSelectionScreen(
      //             restaurante: null,
      //           ));
      //   break;
      return null;
    default:
  }
}
