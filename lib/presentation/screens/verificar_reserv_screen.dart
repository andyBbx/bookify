import 'package:bookify/constants/color.dart';
import 'package:bookify/presentation/widgets/large_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'confirmando_screen.dart';

class VerificarReservaScreen extends StatelessWidget {
  const VerificarReservaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Confirmar reservación",
            style: TextStyle(
                fontSize: 15, color: textDrkgray, fontWeight: FontWeight.w700)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/frame_confermation.png",
            width: widhth,
            height: height,
            fit: BoxFit.cover,
            color: frameColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 50,
              ),
              const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  "assets/images/resutrant_logo1.png",
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Text("Nakama",
                  style: TextStyle(
                      fontSize: 24,
                      color: textDrkgray,
                      fontWeight: FontWeight.w700)),
              // SizedBox(
              //   height: 20,
              // ),
              // SizedBox(
              //   height: 5,
              // ),
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
              //   height: 30,
              // ),
              Text("Verifica los datos tu reserva",
                  style: TextStyle(
                      fontSize: 19,
                      color: textDrkgray,
                      fontWeight: FontWeight.w700)),
              // SizedBox(
              //   height: 30,
              // ),
              Container(
                width: widhth,
                height: 3,
                color: textBold,
              ),
              // SizedBox(
              //   height: 30,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Reservación para",
                      style: TextStyle(
                          fontSize: 17,
                          color: textDrkgray,
                          fontWeight: FontWeight.w100)),
                  // SizedBox(
                  //   width: 2,
                  // ),
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
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                width: widhth,
                height: 1,
                color: textDrkgray.withOpacity(0.3),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                    "*Al confirmar la reservación aceptas los términos y condiciones, así como las políticas de cancelación y reembolsos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: textDrkgray,
                        fontWeight: FontWeight.w300)),
              ),
              SizedBox(
                height: 30,
              ),
              Positioned(
                bottom: 40,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: widhth / 2.5,
                        child: LargeButton2(
                            text: "Cancelar",
                            isRed: true,
                            onTap: () {
                              Navigator.of(context).pop();
                            })),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        width: widhth / 2.5,
                        child: LargeButton2(
                            text: "Aceptar",
                            isRed: false,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ConfirmandoScreen()));
                            })),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
