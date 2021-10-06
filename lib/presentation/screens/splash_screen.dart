import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/presentation/widgets/splash_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'pre_login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PreLoginScreen()),
          ModalRoute.withName('/'));
    });

    return Scaffold(
      backgroundColor: splash_background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              child: Image.asset(
                !isTab() ? "assets/pattern.png" : "assets/pattern.png",
                color: frameColor.withOpacity(0.45),
                fit: isTab() ? BoxFit.cover : BoxFit.cover,
              ),
            ),
          ),
          Align(
              child: logo_splash(
            colorIcon: splash_Logo,
            colorText: splash_Logo,
            subline: true,
          ))
        ],
      ),
    );
  }
}
