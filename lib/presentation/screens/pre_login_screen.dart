import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'auth_screen/login/login_screen.dart';
import 'auth_screen/signup/register_screen.dart';

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      backgroundColor: splash_background,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Image.asset(
          "assets/images/pre_login_bottom_frame.png",
          color: frameColor,
          fit: BoxFit.cover,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              child: Image.asset(
                isLandccape
                    ? "assets/images/pre_login_frame.png"
                    : "assets/images/pre_login_frame.png",
                color: Colors.white.withOpacity(0.8),
                fit: isLandccape ? BoxFit.fitWidth : BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
              top: isTab() ? height / 5 : height / 3,
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                constraints: BoxConstraints(
                  maxWidth: isLandccape ? widht / 2 : widht,
                  minWidth: widht,
                ),
                height: height,
                decoration: BoxDecoration(
                    color: splash_Logo,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(54),
                      topRight: Radius.circular(54),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 20,
                    ),
                    SizedBox(
                        child: SvgPicture.asset(
                      "assets/logo_full.svg",
                      width: widht / 2,
                    )),
                    SizedBox(
                      height: height / 20,
                    ),
                    SizedBox(
                      width: widht / 2,
                      height: height / 20,
                      child: LargeButton(
                        text: "Iniciar sesión",
                        isWhite: false,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: widht / 2,
                      height: height / 20,
                      child: LargeButton(
                        text: "Regístrate",
                        isWhite: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              )),
          // Positioned(
          //   right: 0,
          //   left: 0,
          //   bottom: isLandccape ? -50 : -70,
          //   child: Container(
          //     child: Image.asset(
          //       !isLandccape
          //           ? "assets/images/pre_login_bottom_frame.png"
          //           : "assets/images/pre_login_bottom_frame.png",
          //       color: frameColor,
          //       fit: BoxFit.fitHeight,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
