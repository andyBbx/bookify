import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/widgets/resturantion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MisReservasScreen extends StatefulWidget {
  const MisReservasScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MisReservasScreen> createState() => _MisReservasScreenState();
}

class _MisReservasScreenState extends State<MisReservasScreen> {
  List<ReturantData> _resturants = [
    ReturantData(
        name: "Restaurante japonés",
        adress: "C/ Sagasta 23. Madrid",
        stars: 5,
        images: ["assets/images/resrturant1.png"],
        logo: "assets/images/resutrant_logo1.png",
        isFavv: true,
        description: "Restaurante japonés de la más alta calidad."),
    ReturantData(
        name: "Ikigai",
        adress: "C/ Flor Baja, 5. Madrid",
        stars: 5,
        logo: "assets/images/resturant_logo3.png",
        isFavv: false,
        images: ["assets/images/resturant2.png"],
        description:
            "Restaurante especializado en cocina japonesa de alta calidad."),
    ReturantData(
        name: "Azurmendi",
        adress: "Barrio Leguina, s/n, 48195 Larrabetzu, Biscay, España",
        stars: 5,
        logo: "assets/images/resturant_logo2.png",
        images: ["assets/images/resturant2.png"],
        isFavv: true,
        description: "Cocina vasca de autor"),
  ];

  List<Reservation> resuvations = [
    Reservation(
        restaurantesData: ReturantData(
            name: "Nakama",
            adress: "C/ Flor Baja, 5. Madrid",
            stars: 5,
            logo: "assets/images/resturant_logo2.png",
            isFavv: false,
            images: ["assets/images/resturant_logo2.png"],
            description:
                "Restaurante especializado en cocina japonesa de alta calidad."),
        person: 2,
        info: "Con horario de las 10:30 hrs",
        time: "Hoy 07 de Septiembre de 2021"),
    Reservation(
        restaurantesData: ReturantData(
            name: "Burguer Beer",
            adress: "C/ Sagasta 23. Madrid",
            stars: 4,
            images: ["assets/images/burger_bear.png"],
            logo: "assets/images/burger_bear.png",
            isFavv: true,
            description: "Restaurante japonés de la más alta calidad."),
        person: 2,
        info: "Con horario de las 15:00 hrs",
        time: "05 de Septiembre de 2021"),
    Reservation(
        restaurantesData: ReturantData(
            name: "Nakama",
            adress: "Barrio Leguina, s/n, 48195 Larrabetzu, Biscay, España",
            stars: 5,
            logo: "assets/images/resturant_logo2.png",
            images: ["assets/images/resturant2.png"],
            isFavv: true,
            description: "Cocina vasca de autor"),
        person: 2,
        info: "Con horario de las 10:30 hrs",
        time: "03 de Septiembre de 2021"),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              iconTheme: IconThemeData(
                color: Colors.transparent,
              ),
              collapsedHeight: isTab() ? height / 7 : widhth / 3,
              backgroundColor: Colors.white,
              pinned: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: appgradient,
                ),
                width: widhth,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      "assets/images/reservation_topFrame.png",
                      width: widhth,
                      fit: BoxFit.cover,
                      color: frameColor.withOpacity(0.45),
                    ),
                  ),
                  Positioned(
                      top: 20,
                      left: 20,
                      child: SafeArea(
                          child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ))),
                  Positioned(
                    child: SafeArea(
                      child: Container(
                        width: widhth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Mis reservas",
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Consulta todas tus reservaciones",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100)),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              )),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("Próximas Reservaciones",
                      style: TextStyle(
                          fontSize: 21,
                          color: textDrkgray,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
                children: List.generate(
                    1,
                    (index) => ResturantionItem(
                          reservation: resuvations[index],
                        ))),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: widhth / 5,
                  height: 1,
                  color: devicerColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Historial",
                    style: TextStyle(
                        fontSize: 14,
                        color: textDrkgray,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: widhth / 5,
                  height: 1,
                  color: devicerColor,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
                children: List.generate(
                    resuvations.length - 1,
                    (index) => ResturantionItem(
                          reservation: resuvations[index + 1],
                        ))),
          ),
        ],
      ),
    );
  }
}
