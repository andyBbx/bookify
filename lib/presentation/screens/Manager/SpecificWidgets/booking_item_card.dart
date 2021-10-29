import 'package:flutter/material.dart';

class BookingItemCard extends StatefulWidget {
<<<<<<< HEAD
  final String id;
  Function onTableChangeButton;
  Function onCancelButton;
  BookingItemCard(
      {Key? key,
      required this.id,
      required this.onCancelButton,
      required this.onTableChangeButton})
      : super(key: key);
=======
  BookingItemCard({Key? key}) : super(key: key);
>>>>>>> Manager views

  @override
  _BookingItemCardState createState() => _BookingItemCardState();
}

class _BookingItemCardState extends State<BookingItemCard> {
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
<<<<<<< HEAD
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
                            "2",
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
=======
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 4, color: Colors.orange)),
                    child: Row(
                      children: [
                        Text(
                          "2",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                        Icon(Icons.person)
                      ],
                    ),
                  ), /* Icon(
                    Icons.fastfood_rounded,
                    size: 50,
                    color: Colors.orange,
                  ), */
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
<<<<<<< HEAD
                      Row(
                        children: [
                          Icon(
                            Icons.table_chart,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Mesa sin asignar")
                        ],
                      ),
=======
>>>>>>> Manager views
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
<<<<<<< HEAD
                  onTap: () => widget.onCancelButton(),
=======
>>>>>>> Manager views
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.red,
                      child: const Text(
                        "Eliminar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Expanded(
                child: InkWell(
<<<<<<< HEAD
                  onTap: () => widget.onTableChangeButton(),
=======
>>>>>>> Manager views
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.orangeAccent,
                      child: const Text(
                        "Asignar mesa",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
