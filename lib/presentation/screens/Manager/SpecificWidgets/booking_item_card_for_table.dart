import 'dart:convert';

import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingItemCardForTable extends StatefulWidget {
  final ReservationModel booking;
  Function onTableChangeButton;
  Function onCancelButton;
  Function assignedTables;
  BookingItemCardForTable(
      {Key? key,
      required this.booking,
      required this.onCancelButton,
      required this.onTableChangeButton,
      required this.assignedTables})
      : super(key: key);

  @override
  _BookingItemCardForTableState createState() => _BookingItemCardForTableState();
}

class _BookingItemCardForTableState extends State<BookingItemCardForTable> {
  DateFormat dateFormat = DateFormat('EEEE, d MMM, yyyy', 'es_ES');
  String tableNames = "";

  @override
  void initState() {
    super.initState();
    widget.booking.tables.forEach((tableItem) {
      TableModel table = TableModel.fromJson(tableItem);
      tableNames += "${table.name}, ";
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 8, right: 15),
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 4, color: Colors.orange)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.booking.quantity.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          Icon(Icons.person)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
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
                          Text(widget.booking.quantity.toString() + " Personas")
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
                              child:
                                  Text(dateFormat.format(widget.booking.date)))
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
                                  .parse(widget.booking.time)))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => widget.onCancelButton(),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.red,
                      child: const Text(
                        "Desasignar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => widget.onTableChangeButton(),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.orangeAccent,
                      child: const Text(
                        "Intercambiar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
