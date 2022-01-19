import 'package:bookify/data/models/table.dart';
import 'package:flutter/material.dart';

class TableItem extends StatefulWidget {
  TableModel tableModel;
  Function onBusyTap;
  Function onAvailableTap;
  Function onExchangeTap;
  TableItem(
      {Key? key,
      required this.tableModel,
      required this.onBusyTap,
      required this.onAvailableTap,
      required this.onExchangeTap})
      : super(key: key);

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
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.tableModel.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          ),
          Image.asset(
            "assets/table.png",
            width: 100,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* Flexible(
                    child: Text(
                  widget.tableModel.name,
                  textAlign: TextAlign.right,
                )),
                SizedBox(
                  width: 10,
                ), */
                Icon(
                  Icons.person,
                  color: Colors.orange,
                ),
                Text("x" + widget.tableModel.quantity.toString(), style: TextStyle(fontSize: 18),)
              ],
            ),
          ),
          (widget.tableModel.available) != 2
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: InkWell(
                    //onTap: () => widget.onAvailableTap(),
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                      child: const Text(
                        "Mesa sin asignar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: InkWell(
                        onTap: () => widget.onBusyTap(),
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(width: 2, color: Colors.orange)),
                          child: Text(
                            "Ver reservas",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    /* InkWell(
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
                    ) */
                  ],
                )
        ],
      ),
    );
  }
}
