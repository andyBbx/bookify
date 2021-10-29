import 'package:flutter/material.dart';

class TableItem extends StatefulWidget {
<<<<<<< HEAD

  int id;
  Function onBusyTap;
  Function onAvailableTap;
  Function onExchangeTap;
  TableItem(
      {Key? key,
      required this.id,
      required this.onBusyTap,
      required this.onAvailableTap,
      required this.onExchangeTap})
      : super(key: key);
=======
  TableItem({Key? key}) : super(key: key);
>>>>>>> Manager views

  @override
  _TableItemState createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/table.png",
            width: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Mesa 1"),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.person,
                color: Colors.orange,
              ),
              Text("x4")
            ],
          ),
<<<<<<< HEAD
          widget.id.floor().isEven
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: InkWell(
                    onTap: () => widget.onAvailableTap(),
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 9),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.orange)),
                      child: Text(
                        "Libre",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: InkWell(
                        onTap: () => widget.onBusyTap(),
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 9),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 2, color: Colors.orange)),
                          child: Text(
                            "Ocupada",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => widget.onExchangeTap(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.swap_horiz),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Intercambiar"),
                        ],
                      ),
                    )
                  ],
                )
=======
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: InkWell(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.orange)),
                child: Text(
                  "Libre",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
          )
>>>>>>> Manager views
        ],
      ),
    );
  }
}
