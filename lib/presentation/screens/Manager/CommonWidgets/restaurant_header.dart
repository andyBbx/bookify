import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RestaurantHeader extends StatefulWidget {
  final String title;
  final String subtitle;
  bool hasAction;
  Function? action;
  String? actionText;

  RestaurantHeader(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.hasAction = false,
      this.action,
      this.actionText})
      : super(key: key);

  @override
  _RestaurantHeaderState createState() => _RestaurantHeaderState();
}

class _RestaurantHeaderState extends State<RestaurantHeader> {
  Widget actionButton(Function action, String text) {
    return InkWell(
      child: Container(
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.orange, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        action();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Positioned(
              top: 0,
              left: 150,
              child: SvgPicture.asset("assets/frame_hometab.svg")),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(30),
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
                      : SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  !widget.hasAction
                      ? const SizedBox()
                      : actionButton(widget.action!, widget.actionText!)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
