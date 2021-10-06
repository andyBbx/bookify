import 'package:bookify/constants/color.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final bool isWhite;
  final Function onTap;

  const LargeButton(
      {Key? key,
      required this.text,
      required this.isWhite,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isWhite
        ? InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                  gradient: appgradient,
                  borderRadius: BorderRadius.all(Radius.circular(34))),
              child: Center(
                child: Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          )
        : InkWell(
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
                  borderRadius: BorderRadius.all(Radius.circular(34))),
              child: Center(
                child: Text(text,
                    style: TextStyle(color: buttonBorder, fontSize: 16)),
              ),
            ),
          );
  }
}
