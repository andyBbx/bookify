import 'package:bookify/constants/color.dart';
import 'package:flutter/material.dart';

class LargeButton2 extends StatelessWidget {
  final String text;
  final bool isRed;
  final Function onTap;

  const LargeButton2(
      {Key? key, required this.text, required this.isRed, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isRed
        ? InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: buttonBorder,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(34))),
              child: Center(
                child: Text(text,
                    style: TextStyle(color: buttonBorder, fontSize: 16)),
              ),
            ))
        : InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: largebuttonBorder,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(34))),
              child: Center(
                child: Text(text,
                    style: TextStyle(color: largebuttonBorder, fontSize: 16)),
              ),
            ),
          );
  }
}
