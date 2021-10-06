import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
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

    return Container(
      decoration: BoxDecoration(
          color: splash_background,
          image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image: AssetImage(
                !isLandccape ? "assets/pattern.png" : "assets/pattern.png",
              ))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.all(widht / 8),
                height: height / 1.7,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: const Radius.circular(50))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: SvgPicture.asset(
                      "assets/logo_full.svg",
                      width: widht / 1.8,
                    )),
                    SizedBox(
                      height: height / 20,
                    ),
                    SizedBox(
                      width: widht / 1.2,
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
                      height: height / 40,
                    ),
                    SizedBox(
                      width: widht / 1.2,
                      child: LargeButton(
                          text: "Regístrate",
                          isWhite: false,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                          }
                          //

                          ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                        image: AssetImage(
                          !isLandccape
                              ? "assets/halfPattern.png"
                              : "assets/halfPattern.png",
                        )),),
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: splash_background,
    //   // bottomNavigationBar: Container(
    //   //   color: Colors.white,
    //   //   child: Image.asset(
    //   //     "assets/images/pre_login_bottom_frame.png",
    //   //     color: frameColor,
    //   //     fit: BoxFit.cover,
    //   //   ),
    //   // ),
    //   body: Stack(
    //     children: [
    //       Container(
    //         child: Image.asset(
    //           isLandccape
    //               ? "assets/images/pre_login_frame.png"
    //               : "assets/images/pre_login_frame.png",
    //           color: Colors.white,
    //           fit: isLandccape ? BoxFit.fitWidth : BoxFit.fitHeight,
    //         ),
    //       ),
    //       Positioned(
    //           top: isTab() ? height / 5 : height / 3,
    //           child: Container(
    //             // padding: EdgeInsets.only(top: 50, left: 20, right: 20),
    //             constraints: BoxConstraints(
    //               maxWidth: isLandccape ? widht / 2 : widht,
    //               minWidth: widht,
    //             ),
    //             height: height,
    //             decoration: const BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(54),
    //                   topRight: Radius.circular(54),
    //                 )),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 // SizedBox(
    //                 //   height: height / 20,
    //                 // ),
    // SizedBox(
    //     child: SvgPicture.asset(
    //   "assets/logo_full.svg",
    //   width: widht / 2,
    // )),
    // // SizedBox(
    // //   height: height / 20,
    // // ),
    // SizedBox(
    //   width: widht / 1.2,
    //   child: LargeButton(
    //     text: "Iniciar sesión",
    //     isWhite: false,
    //     onTap: () {
    //       Navigator.of(context).push(MaterialPageRoute(
    //           builder: (context) => LoginScreen()));
    //     },
    //   ),
    // ),
    // // SizedBox(
    // //   height: 10,
    // // ),
    // SizedBox(
    //   width: widht / 1.2,
    //   child: LargeButton(
    //       text: "Regístrate",
    //       isWhite: false,
    //       onTap: () {
    //         Navigator.of(context).push(MaterialPageRoute(
    //             builder: (context) => RegisterScreen()));
    //       }
    //       //

    //       ),
    // ),
    // // SizedBox(
    // //   width: widht / 2,
    // //   height: height / 20,
    // //   child: LargeButton(
    // //     text: "Regístrate",
    // //     isWhite: true,
    // //     onTap: () {
    // // Navigator.of(context).push(MaterialPageRoute(
    // //     builder: (context) => RegisterScreen()));
    // //     },
    // //   ),
    // // ),
    //                 SizedBox(
    //                   height: 100,
    //                 ),
    //               ],
    //             ),
    //           )),
    //       // Positioned(
    //       //   right: 0,
    //       //   left: 0,
    //       //   bottom: isLandccape ? -50 : -70,
    //       //   child: Container(
    //       //     child: Image.asset(
    //       //       !isLandccape
    //       //           ? "assets/images/pre_login_bottom_frame.png"
    //       //           : "assets/images/pre_login_bottom_frame.png",
    //       //       color: frameColor,
    //       //       fit: BoxFit.fitHeight,
    //       //     ),
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
