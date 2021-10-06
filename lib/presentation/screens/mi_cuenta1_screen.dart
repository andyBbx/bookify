import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'confirmando_screen.dart';

class MiCuenta1Screen extends StatefulWidget {
  const MiCuenta1Screen({Key? key}) : super(key: key);

  @override
  State<MiCuenta1Screen> createState() => _MiCuenta1ScreenState();
}

class _MiCuenta1ScreenState extends State<MiCuenta1Screen> {
  TextEditingController nombres = TextEditingController();
  TextEditingController primer_apellido = TextEditingController();
  TextEditingController segundo_apellido = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController ubicacion = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombres.text = "Andy Sandoval";
    primer_apellido.text = "Sandoval";
    segundo_apellido.text = "Gómez";
    telefono.text = "123 456 7890";
    correo.text = "andi@correo.com";
    ubicacion.text = "Calle Don José 3";
  }

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              iconTheme: const IconThemeData(
                color: Colors.transparent,
              ),
              collapsedHeight: isTab() ? height / 4 : widhth / 1.2,
              backgroundColor: Colors.white,
              pinned: true,
              flexibleSpace: Container(
                width: widhth,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  "assets/halfPattern.png",
                ))),
                child: Stack(children: [
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
                    top: 20,
                    left: 0,
                    child: SafeArea(
                      child: Container(
                        width: widhth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Mi cuenta",
                              style: TextStyle(
                                  fontSize: 26,
                                  color: textDrkgray,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                "assets/images/profile.png",
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Toca para cambiar tu foto",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: textDrkgray,
                                    fontWeight: FontWeight.w100)),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              )),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              constraints: BoxConstraints(
                maxWidth: isLandccape ? widhth / 2 : widhth,
                minWidth: widhth,
              ),
              decoration: BoxDecoration(
                color: splash_Logo,
              ),
              child: Column(
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      controller: nombres,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        label: Text("Nombre(s)",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Nombre(s)",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: primer_apellido,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        label: Text("Primer apellido",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Primer apellido",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: segundo_apellido,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        hintText: "Segundo apellido",
                        label: Text("Segundo apellido",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: telefono,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        hintText: "Teléfono",
                        label: Text("Teléfono",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/phone.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: correo,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        fillColor: Colors.red,
                        hintText: "Correo",
                        label: Text("Correo",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/mail.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: ubicacion,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: splash_background),
                        ),
                        hintText: "Ubicación",
                        label: Text("Ubicación",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/location.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      child: LargeButton(
                          text: "Guardar cambios",
                          isWhite: false,
                          onTap: () {
                            Navigator.of(context).pop();
                          })),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      child: LargeButton(
                          text: "Cambiar contraseña",
                          isWhite: false,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ConfirmandoScreen()));
                          })),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
