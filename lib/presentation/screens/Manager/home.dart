import 'dart:convert';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/owned_restaurant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/booking_requests/booking_requests_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/CurrentRestaurant/bloc/current_restaurant_bloc.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/bloc/owned_restaurants_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/views/booking_items.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/views/booking_requests.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/view/owned_restaurants.dart';
import 'package:bookify/presentation/screens/Manager/Tables/views/restaurant_tables.dart';
import 'package:bookify/presentation/screens/home/tabs/profile_tab.dart';
import 'package:bookify/presentation/screens/miCuenta/mi_cuenta1_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerView extends StatefulWidget {
  ManagerView({Key? key}) : super(key: key);

  @override
  _ManagerViewState createState() => _ManagerViewState();
}

class _ManagerViewState extends State<ManagerView> {
  final GlobalKey<_ManagerViewState> _key = GlobalKey();
  User user = User();
  int _currentIndex = 0;
  List _children = [];
  OwnedRestaurantModel currentRestaurant = OwnedRestaurantModel(
      id: "",
      logo: "",
      name: "",
      description: "",
      phone: "",
      address: "",
      postalCode: "",
      municipality: "",
      province: "",
      country: "",
      web: "",
      rating: "");

  @override
  void initState() {
    super.initState();
    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        BlocProvider.of<OwnedRestaurantsBloc>(context)
            .add(LoadOwnedRestaurants());
        setState(() {
          user = user.fromJson(jsonDecode(userModelString!));
          try {
            currentRestaurant = OwnedRestaurantModel.fromJson(
                jsonDecode(prefs.getString("current_restaurant")!));

            print("Current: " + currentRestaurant.id);
            if (currentRestaurant.id.isNotEmpty) {
              BlocProvider.of<CurrentRestaurantBloc>(context)
                  .add(SetCurrentRestaurant(restaurant: currentRestaurant));
              BlocProvider.of<BookingRequestsBloc>(context).add(
                  LoadUnconfirmedBookings(restaurantId: currentRestaurant.id));
              BlocProvider.of<BookingsBloc>(context).add(
                  LoadConfirmedBookings(restaurantId: currentRestaurant.id));

              BlocProvider.of<TablesBloc>(context).add(
                  LoadRestaurantTables(restaurantId: currentRestaurant.id));
            }
          } catch (e) {
            print("Couldn't get the restaurant");
          }
        });
        if ((user.id)!.isEmpty) {
          //logout;
        }
      }

      setState(() {
        _children = [
          BookingRequests(tabListener: onTabTapped),
          BookingItems(tabListener: onTabTapped),
          RestaurantTables(tabListener: onTabTapped),
          MyOwnedRestaurants(),
          MiCuenta1Screen()
        ];
      });
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children.isEmpty ? SizedBox() : _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text('Nuevas'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.today),
            title: Text('Reservas'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.table_chart), title: Text('Mesas')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.store), title: Text('Restaurante')),
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              title: Text('Mi Cuenta'))
        ],
      ),
    );
  }
}
