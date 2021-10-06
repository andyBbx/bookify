import 'package:flutter/material.dart';

//#FF6A00 - #FF9300
Color gradient1 = const Color(0xFFDB7714);
Color gradient2 = const Color(0xFFFF9300);
Color splash_background = const Color(0xFFDB7714);
Color splash_Logo = const Color(0xFFFFFFFF);
Color textBold = const Color(0xFFEA8928);
Color textDrkgray = const Color(0xFF717171);
Color textBlack = const Color(0xFF383838);
//#E6E6E6
Color devicerColor = const Color(0xFFE6E6E6);
Color tabunsellected = const Color(0xFFE6E6E6);
//#FF004E
Color favrioteColor = const Color(0xFFFF004E);

Color largebuttonBorder = const Color(0xFFDD5555);

Color backgroundColor = const Color(0XFFF7F7F7);

Color buttonBorder = const Color(0xFFEA8827);

Color frameColor = const Color(0xFFFFC68D);

final LinearGradient appgradient = LinearGradient(
    colors: [gradient2, gradient1],
    begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(0.5, 0.0),
    stops: const [0.0, 1.0],
    tileMode: TileMode.clamp);
