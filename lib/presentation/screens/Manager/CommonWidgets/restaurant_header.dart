import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RestaurantHeader extends StatefulWidget {
  final String title;
  final String subtitle;

  RestaurantHeader({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  _RestaurantHeaderState createState() => _RestaurantHeaderState();
}

class _RestaurantHeaderState extends State<RestaurantHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4), // Shadow position
          ),
        ],
      ),
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  widget.subtitle != ""
                      ? Text(widget.subtitle, style: TextStyle(fontSize: 15))
                      : SizedBox()
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 150,
              child: SvgPicture.asset("assets/frame_hometab.svg")),
        ],
      ),
    );
  }
}
