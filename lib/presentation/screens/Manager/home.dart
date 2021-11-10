import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/Manager/booking_items.dart';
import 'package:bookify/presentation/screens/Manager/booking_requests.dart';
import 'package:bookify/presentation/screens/Manager/owned_restaurants.dart';
import 'package:bookify/presentation/screens/Manager/restaurant_tables.dart';
import 'package:bookify/presentation/screens/home/tabs/profile_tab.dart';
import 'package:bookify/presentation/screens/miCuenta/mi_cuenta1_screen.dart';
import 'package:flutter/material.dart';

class ManagerView extends StatefulWidget {
  ManagerView({Key? key}) : super(key: key);

  @override
  _ManagerViewState createState() => _ManagerViewState();
}

class _ManagerViewState extends State<ManagerView> {

  int _currentIndex = 0;
 final List _children = [
   BookingRequests(),
   BookingItems(),
   RestaurantTables(),
   MyOwnedRestaurants(),
   MiCuenta1Screen()
 ];

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: _children[_currentIndex], // new
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
           icon: Icon(Icons.table_chart),
           title: Text('Mesas')
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.store),
           title: Text('Restaurante')
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.person, color: Colors.grey,),
           title: Text('Mi Cuenta')
         )
       ],
     ),
   );
  }
}