import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:flutter/material.dart';

class BookingItems extends StatefulWidget {
  BookingItems({Key? key}) : super(key: key);

  @override
  _BookingItemsState createState() => _BookingItemsState();
}

class _BookingItemsState extends State<BookingItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          RestaurantHeader(
            title: "Reservaciones",
            subtitle: "Azurmendi",
          ),
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              itemCount: 10,
              itemBuilder: (context, index) {
                return BookingItemCard();
              },
            ),
          )
        ],
      ),
    );
  }
}
