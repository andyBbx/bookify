import 'package:flutter/material.dart';

class BookingRequestCard extends StatefulWidget {
<<<<<<< HEAD
  final String id;
  Function onAcceptButton;
  Function onRejectButton;
  BookingRequestCard({Key? key, required this.id, required this.onAcceptButton, required this.onRejectButton})
      : super(key: key);
=======
  BookingRequestCard({Key? key}) : super(key: key);
>>>>>>> Manager views

  @override
  _BookingRequestCardState createState() => _BookingRequestCardState();
}

class _BookingRequestCardState extends State<BookingRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
      width: double.infinity,
=======
>>>>>>> Manager views
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
<<<<<<< HEAD
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
=======
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
>>>>>>> Manager views
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
<<<<<<< HEAD
                          Flexible(child: Text("7 de Noviembre de 2021"))
=======
                          Text("7 de Noviembre de 2021")
>>>>>>> Manager views
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
<<<<<<< HEAD
                            Icons.access_time,
=======
                            Icons.today,
>>>>>>> Manager views
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
<<<<<<< HEAD
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
                        "Rechazar",
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
                      "Aceptar",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
              )),
            ],
          ),
=======
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
>>>>>>> Manager views
        ],
      ),
    );
  }
}
