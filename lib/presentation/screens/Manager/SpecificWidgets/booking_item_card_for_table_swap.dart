import 'dart:convert';

import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingItemCardForTableSwap extends StatelessWidget {
  final ReservationModel booking;
  Function onTableChangeButton;
  Function onCancelButton;
  Function assignedTables;
  BookingItemCardForTableSwap(
      {Key? key,
      required this.booking,
      required this.onCancelButton,
      required this.onTableChangeButton,
      required this.assignedTables})
      : super(key: key);

  DateFormat dateFormat = DateFormat('EEEE, d MMM, yyyy', 'es_ES');
  String tableNames = "";
  List<String> tableIds = [];
  List<TableModel> bookingTables = [];

  @override
  Widget build(BuildContext context) {
    booking.tables.forEach((tableItem) {
      TableModel table = TableModel.fromJson(tableItem);
      tableNames += "${table.name}, ";
    });

    for (var i = 0; i < booking.tables.length; i++) {
      bookingTables.add(TableModel.fromJson(booking.tables[i]));
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(booking.quantity.toString() + " Personas")
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.today,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Text(dateFormat.format(booking.date)))
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("A las " +
                        DateFormat.jm().format(DateFormat("hh:mm:ss")
                            .parse(booking.time)))
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.orange.withOpacity(0.05),
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: bookingTables.length,
                itemBuilder: (BuildContext context, int tableIndex) {
                  return TextButton(
                    child: Text("${bookingTables[tableIndex].name} - (${bookingTables[tableIndex].quantity} pers.)"),
                    onPressed: (){
                      onTableChangeButton(booking.id,bookingTables[tableIndex].id);
                    },
                  );
                }),
          ),
          /* Row(
            children: [
              Icon(
                Icons.table_chart,
                color: Colors.orange,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: InkWell(
                  onTap: () => widget.assignedTables(),
                  child: Text(
                    "Mesas: " +
                        ((widget.booking.tables.isNotEmpty)
                            ? tableNames /* widget.booking.tables.join(', ') */
                            : "Sin asignar"),
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ), */
          /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => widget.onTableChangeButton(),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      color: Colors.orangeAccent,
                      child: const Text(
                        "Intercambiar con esta reserva",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ), */
        ],
      ),
    );
  }
}
