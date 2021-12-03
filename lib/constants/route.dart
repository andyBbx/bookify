import 'package:bookify/presentation/screens/Manager/Bookings/bloc/booking_requests/booking_requests_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/CurrentRestaurant/bloc/current_restaurant_bloc.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/bloc/owned_restaurants_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Table/bloc/table_bloc.dart';
import 'package:bookify/presentation/screens/Manager/TableBookings/bloc/table_bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/screens/Manager/home.dart';
import 'package:bookify/presentation/screens/auth_screen/login/login_screen.dart';
import 'package:bookify/presentation/screens/auth_screen/signup/register_screen.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/home/home_screen.dart';
import 'package:bookify/presentation/screens/home/tabs/mis_reservas_screen.dart';
import 'package:bookify/presentation/screens/miCuenta/bloc/micuenta_bloc.dart';
import 'package:bookify/presentation/screens/pre_login_screen.dart';
import 'package:bookify/presentation/screens/restaurant_info/view/resutrant_selection_screen.dart';
import 'package:bookify/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route? appRouteGaneragte(RouteSettings _routeSettings) {
  switch (_routeSettings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => PreLoginScreen());
    //break;
    case "/splash":
      return MaterialPageRoute(builder: (context) => SplashScreen());
    //break;
    case "/login":
      return MaterialPageRoute(builder: (context) => LoginScreen());
    //break;
    case "/signup":
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    //break;
    // case "/home":
    //   return MaterialPageRoute(builder: (context) => HomeScreen());
    //   break;
    case "/home":
      return MaterialPageRoute(builder: (context) => HomeScreen());
    //break;
    case "/managerView":
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
                BlocProvider(
                  create: (context) => OwnedRestaurantsBloc(context),
                ),
                BlocProvider(
                  create: (context) => TablesBloc(),
                ),
                BlocProvider(
                  create: (context) => TableBloc(),
                ),
                BlocProvider(
                  create: (context) => BookingsBloc(),
                ),
                BlocProvider(
                  create: (context) => BookingRequestsBloc(),
                ),
                BlocProvider(
                  create: (context) => TableBookingsBloc(),
                ),
                BlocProvider(
                  create: (context) => CurrentRestaurantBloc(),
                ),
                BlocProvider(
                  create: (context) => MicuentaBloc(),
                ),
                BlocProvider(
                  create: (context) => HomeBloc(context),
                ),
              ], child: ManagerView()));
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
