import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:flutter/material.dart';

class ReservarItem extends StatelessWidget {
  const ReservarItem({Key? key, required this.title, required this.isWhite})
      : super(key: key);

  final String title;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bocwidth = 2.5;
    double heoght = 3.5;

    return isWhite
        ? Container(
            width: widhth / bocwidth,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2), // Shadow position
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    "assets/home/box_frame2.png",
                    alignment: Alignment.centerRight,
                    color: const Color(0xFFFFC68D).withAlpha(70),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                    child: Text(
                  title,
                  style: TextStyle(
                      color: splash_background,
                      fontSize: isTab() ? 22 : 16,
                      fontWeight: FontWeight.bold),
                ))
              ],
            ),
          )
        : Container(
            height: widhth / heoght,
            width: widhth / bocwidth,
            decoration: BoxDecoration(
              gradient: appgradient,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2), // Shadow position
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    "assets/home/frame_box.png",
                    alignment: Alignment.centerRight,
                    color: Colors.white.withAlpha(70),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                    child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ))
              ],
            ),
          );
  }
}
