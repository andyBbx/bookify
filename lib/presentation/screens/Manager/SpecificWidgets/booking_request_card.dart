import 'package:flutter/material.dart';

class BookingRequestCard extends StatefulWidget {
  BookingRequestCard({Key? key}) : super(key: key);

  @override
  _BookingRequestCardState createState() => _BookingRequestCardState();
}

class _BookingRequestCardState extends State<BookingRequestCard> {
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
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.fastfood_rounded,
                    size: 50,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
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
                          Text("2 Personas")
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
                          Text("7 de Noviembre de 2021")
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
                          Text("A las 10:30 hrs")
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          InkWell(
            child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.orangeAccent,
                child: const Text(
                  "Asignar mesa",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
