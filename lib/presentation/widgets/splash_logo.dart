import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class logo_splash extends StatelessWidget {
  const logo_splash({
    Key? key,
    required this.colorText,
    required this.colorIcon,
    required this.subline,
  }) : super(key: key);
  final Color colorText;
  final Color colorIcon;
  final bool subline;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(Size(300, 200)),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/logo_icon.svg",
            color: colorIcon,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "RESERVA",
            style: TextStyle(color: colorText, fontSize: 25),
          ),
          subline
              ? Text(
                  " en los mejores restaurantes",
                  style: TextStyle(color: colorText, fontSize: 15),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          subline
              ? Container(
                  width: 70,
                  height: 10,
                  decoration: BoxDecoration(
                      color: colorIcon,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                )
              : Container(),
        ],
      ),
    );
  }
}
