import 'package:bookify/constants/color.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'reserva_confirmada_screen.dart';

class ConfirmandoScreen extends StatelessWidget {
  const ConfirmandoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/confermation_2.png",
            width: widhth,
            height: height,
            fit: BoxFit.fill,
            color: frameColor.withOpacity(0.45),
          ),
          Positioned(
              top: 20,
              left: 20,
              child: SafeArea(
                  child: Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_left,
                    color: textBold,
                    size: 30,
                  ),
                ],
              ))),
          Positioned(
              top: height / 10,
              left: 0,
              child: SafeArea(
                  child: Container(
                width: widhth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        "assets/images/resturant_logoTest.png",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Nakama",
                        style: TextStyle(
                            fontSize: 24,
                            color: textDrkgray,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Confirmando",
                        style: TextStyle(
                            fontSize: 20,
                            color: textBold,
                            fontWeight: FontWeight.w700)),
                    Image.asset(
                      "assets/images/icons/threedots.png",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      child: Text("El restaurante tiene hasta las",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: textDrkgray,
                              fontWeight: FontWeight.w700)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("9:43",
                            style: TextStyle(
                                fontSize: 40,
                                color: textBold,
                                fontWeight: FontWeight.w900)),
                        SizedBox(
                          width: 2,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Text("hrs",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: textBold,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Text("para confirmar tu reserva",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: textDrkgray,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    SizedBox(
                        width: widhth / 2.6,
                        child: LargeButton(
                            text: "Cancelar",
                            isWhite: true,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ReservaConfirmadaScreen()));
                            })),
                  ],
                ),
              ))),
        ],
      ),
    );
  }
}
