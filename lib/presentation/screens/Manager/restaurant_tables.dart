import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/table_item_card.dart';
import 'package:flutter/material.dart';

class RestaurantTables extends StatefulWidget {
  RestaurantTables({Key? key}) : super(key: key);

  @override
  _RestaurantTablesState createState() => _RestaurantTablesState();
}

class _RestaurantTablesState extends State<RestaurantTables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 29,
        ),
        backgroundColor: Colors.orange,
        tooltip: 'Agregar nueva mesa',
        elevation: 5,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            RestaurantHeader(
              title: "Mesas",
              subtitle: "Azurmendi",
            ),
            Flexible(
              child: GridView.builder(
                  padding: EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 5),
                  itemCount: 10,
                  itemBuilder: (BuildContext ctx, index) {
                    return TableItem();
                  }), /* GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return BookingItemCard();
                },
              ) */
            )
          ],
        ),
      ),
    );
  }
}
