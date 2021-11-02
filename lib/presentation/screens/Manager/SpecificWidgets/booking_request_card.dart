import 'package:flutter/material.dart';

class BookingRequestCard extends StatefulWidget {
<<<<<<< HEAD
<<<<<<< HEAD
  final String id;
  Function onAcceptButton;
  Function onRejectButton;
  BookingRequestCard({Key? key, required this.id, required this.onAcceptButton, required this.onRejectButton})
      : super(key: key);
=======
  BookingRequestCard({Key? key}) : super(key: key);
>>>>>>> Manager views
=======
  final String id;
  Function onTap;
  BookingRequestCard({Key? key, required this.id, required this.onTap})
      : super(key: key);
>>>>>>> Design adjustments, dialog for assigning tables and my account page

  @override
  _BookingRequestCardState createState() => _BookingRequestCardState();
}

class _BookingRequestCardState extends State<BookingRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
<<<<<<< HEAD
      width: double.infinity,
=======
>>>>>>> Manager views
=======
      width: double.infinity,
>>>>>>> Design adjustments, dialog for assigning tables and my account page
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
<<<<<<< HEAD
=======
>>>>>>> Design adjustments, dialog for assigning tables and my account page
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.fastfood_rounded,
                      size: 50,
                      color: Colors.orange,
                    ),
<<<<<<< HEAD
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
=======
                  ),
                ),
                Expanded(
                  flex: 4,
>>>>>>> Design adjustments, dialog for assigning tables and my account page
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
<<<<<<< HEAD
                          Flexible(child: Text("7 de Noviembre de 2021"))
=======
                          Text("7 de Noviembre de 2021")
>>>>>>> Manager views
=======
                          Flexible(child: Text("7 de Noviembre de 2021"))
>>>>>>> Design adjustments, dialog for assigning tables and my account page
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
<<<<<<< HEAD
<<<<<<< HEAD
                            Icons.access_time,
=======
                            Icons.today,
>>>>>>> Manager views
=======
                            Icons.access_time,
>>>>>>> Design adjustments, dialog for assigning tables and my account page
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
<<<<<<< HEAD
=======
>>>>>>> Design adjustments, dialog for assigning tables and my account page
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
<<<<<<< HEAD
                  onTap: () => widget.onRejectButton(),
=======
>>>>>>> Design adjustments, dialog for assigning tables and my account page
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
<<<<<<< HEAD
                onTap: () => widget.onAcceptButton(),
=======
                onTap: () => widget.onTap(),
>>>>>>> Design adjustments, dialog for assigning tables and my account page
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
<<<<<<< HEAD
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
=======
>>>>>>> Design adjustments, dialog for assigning tables and my account page
        ],
      ),
    );
  }
}
