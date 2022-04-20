import 'package:bookify/constants/color.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ReservaConfirmadaScreen extends StatelessWidget {
  const ReservaConfirmadaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/confermation_2.png",
            width: widhth,
            height: height,
            fit: BoxFit.cover,
            color: frameColor.withOpacity(0.45),
          ),
          SizedBox(
            height: height - height / 3,
            child: Positioned(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(
                //   child: Image.asset(
                //     "assets/images/icons/logo_holloow.png",
                //   ),
                // ),
                Icon(
                  Icons.food_bank,
                  size: 80,
                  color: splash_background,
                ),
                Text('Reserva confirmada',
                    style: TextStyle(
                        fontSize: 28,
                        color: splash_background,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 100,
                  height: 60,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(
                          "assets/images/resturant_logoTest.png",
                          height: 60,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/icons/check_mark.png",
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                ),
                Text("Nakama",
                    style: TextStyle(
                        fontSize: 28,
                        color: textDrkgray,
                        fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Text("Restaurante japonés ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: textDrkgray,
                          fontWeight: FontWeight.w700)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/icons/location.svg",
                      fit: BoxFit.scaleDown,
                      width: 11,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("C/ Sagasta 23. Madrid",
                        style: TextStyle(
                          color: textDrkgray,
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                    width: widhth / 2.6,
                    child: LargeButton(
                        text: "¿Cómo llegar?", isWhite: true, onTap: () {})),
                // SizedBox(
                //   height: 20,
                // ),
                SizedBox(
                    width: widhth / 2.6,
                    child: LargeButton(
                        text: "Llamar", isWhite: true, onTap: () {}))
              ],
            )),
          ),
          Positioned(
              bottom: 0,
              child: Stack(
                children: [
                  Container(
                    width: widhth,
                    height: height / 3,
                    decoration: BoxDecoration(
                      gradient: appgradient,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/images/confermation_box_botto.png",
                    width: widhth,
                    height: height / 3,
                    fit: BoxFit.cover,
                    color: frameColor.withOpacity(0.45),
                  ),
                  Container(
                    width: widhth,
                    height: height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Detalles de la reserva",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: widhth / 10),
                          padding: EdgeInsets.symmetric(vertical: height / 30),
                          height: height / 5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Reserva para",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: textDrkgray,
                                          fontWeight: FontWeight.w100)),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(" 2 Personas",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: textBold,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Hoy 07 de Septiembre de 2021",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: textBold,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Con horario de las",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: textDrkgray,
                                          fontWeight: FontWeight.w100)),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text("10:30 hrs",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: textBold,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
