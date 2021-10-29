import 'package:flutter/material.dart';

class TableItem extends StatefulWidget {
  TableItem({Key? key}) : super(key: key);

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
        ],
      ),
    );
  }
}
