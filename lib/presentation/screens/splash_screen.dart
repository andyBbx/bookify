import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/widgets/splash_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'pre_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User user = User();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Utils().startSharedPreferences().then((prefs) {
      print("Test 1");
      String? userModelString = prefs.getString("user");
      print(userModelString);
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));
        if ((user.id)!.isEmpty) {
          //logout;
          print("logout");
        } else {
          print("login");
        }
        Future.delayed(Duration(milliseconds: 2000), () {
          if ((user.id)!.isNotEmpty) {
            if (user.isManager) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/managerView", (Route route) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (Route route) => false);
            }
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const PreLoginScreen()),
                (route) => false);
          }
        });
      } else {
        /* print("Pollo"); */
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const PreLoginScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

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
          Align(child: logo(500)
              //     child: logo_splash(
              //   colorIcon: splash_Logo,
              //   colorText: splash_Logo,
              //   subline: true,
              // )
              )
        ],
      ),
    );
  }
}
