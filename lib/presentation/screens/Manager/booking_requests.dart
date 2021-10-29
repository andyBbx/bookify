import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:flutter/material.dart';

class BookingRequests extends StatefulWidget {
  BookingRequests({Key? key}) : super(key: key);

  @override
  _BookingRequestsState createState() => _BookingRequestsState();
}

class _BookingRequestsState extends State<BookingRequests> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          RestaurantHeader(
            title: "Solicitudes",
            subtitle: "Azurmendi",
          ),
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              itemCount: 10,
              itemBuilder: (context, index) {
                return BookingRequestCard();
              },
            ),
          )
        ],
      ),
    );
  }
}
