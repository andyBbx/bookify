import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/widgets/resturantion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MisReservasScreen extends StatefulWidget {
  final List<ReservationModel> reservations;
  const MisReservasScreen({Key? key, required this.reservations})
      : super(key: key);

  @override
  State<MisReservasScreen> createState() => _MisReservasScreenState();
}

class _MisReservasScreenState extends State<MisReservasScreen> {
  List<ReservationModel> next_reservationList = [];

  List<ReservationModel> historial_reservationList = [];

  @override
  void initState() {
    for (var i = 0; i < widget.reservations.length; i++) {
      if (widget.reservations[i].date.isAfter(DateTime.now())) {
        historial_reservationList.add(widget.reservations[i]);
      } else {
        next_reservationList.add(widget.reservations[i]);
      }
    }

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
              iconTheme: const IconThemeData(
                color: Colors.white,
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
                    child: SafeArea(
                      child: Container(
                        width: widhth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: isTab() ? widhth / 10 : 0),
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
                  Column(
                      children: List.generate(
                          historial_reservationList.length,
                          (index) => ResturantionItem(
                                reservation: historial_reservationList[index],
                                history: false,
                              ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: widhth / 5,
                        height: 1,
                        color: devicerColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text("Historial",
                          style: TextStyle(
                              fontSize: 21,
                              color: textDrkgray,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: widhth / 5,
                        height: 1,
                        color: devicerColor,
                      ),
                    ],
                  ),
                  Column(
                      children: List.generate(
                          next_reservationList.length,
                          (index) => ResturantionItem(
                                reservation: next_reservationList[index],
                                history: true,
                              ))),
                ],
              ),
            ),
          )
          // SliverToBoxAdapter(
          //   child: Column(
          //     children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: Text("Próximas Reservaciones",
          //       style: TextStyle(
          //           fontSize: 21,
          //           color: textDrkgray,
          //           fontWeight: FontWeight.w700)),
          // ),
          //     ],
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Column(
          // children: List.generate(
          //     1,
          //     (index) => ResturantionItem(
          //           reservation: resuvations[index],
          //         ))),
          // ),
          // SliverToBoxAdapter(
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       width: widhth / 5,
          //       height: 1,
          //       color: devicerColor,
          //     ),
          //    const SizedBox(
          //       width: 20,
          //     ),
          //     Text("Historial",
          //         style: TextStyle(
          //             fontSize: 14,
          //             color: textDrkgray,
          //             fontWeight: FontWeight.w700)),
          //    const SizedBox(
          //       width: 20,
          //     ),
          //     Container(
          //       width: widhth / 5,
          //       height: 1,
          //       color: devicerColor,
          //     ),
          //   ],
          // ),
          // ),
          // SliverToBoxAdapter(
          // child: Column(
          //     children: List.generate(
          //         resuvations.length - 1,
          //         (index) => ResturantionItem(
          //               reservation: resuvations[index + 1],
          //             ))),
          // ),
        ],
      ),
    );
  }
}
