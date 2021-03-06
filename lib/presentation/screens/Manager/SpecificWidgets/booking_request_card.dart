import 'package:bookify/data/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingRequestCard extends StatefulWidget {
  final ReservationModel booking;
  Function onAcceptButton;
  Function onRejectButton;
  BookingRequestCard(
      {Key? key,
      required this.booking,
      required this.onAcceptButton,
      required this.onRejectButton})
      : super(key: key);

  @override
  _BookingRequestCardState createState() => _BookingRequestCardState();
}

class _BookingRequestCardState extends State<BookingRequestCard> {
  DateFormat dateFormat = DateFormat('EEEE, d MMM, yyyy', 'es_ES');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.fastfood_rounded,
                      size: 50,
                      color: Colors.orange,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
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
                  onTap: () => widget.onRejectButton(),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.red,
                      child: const Text(
                        "Rechazar reserva",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Expanded(
                  child: InkWell(
                onTap: () => widget.onAcceptButton(),
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    color: Colors.orangeAccent,
                    child: const Text(
                      "Aceptar reserva",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
