import 'dart:convert';

import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/home_screen.dart';
import 'package:bookify/presentation/screens/home/tabs/mis_reservas_screen.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'home/bloc/home_bloc.dart';

class ConfirmandoScreen extends StatelessWidget {
  final ReservationModel reservationModel;
  const ConfirmandoScreen({Key? key, required this.reservationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    User user = User();

    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));

        if ((user.id)!.isEmpty) {
          //logout;
        }
      }
    });

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/confermation_2.png",
                      ))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widhth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        reservationModel.restaurantData.cover == null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                // backgroundImage: AssetImage(
                                //   "assets/images/resutrant_logo1.png",
                                // ),
                                child: logo(250),
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  "assets/images/resutrant_logo1.png",
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(reservationModel.restaurantData.name,
                            style: TextStyle(
                                fontSize: 24,
                                color: textDrkgray,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(
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
                        const SizedBox(
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
                        Text(
                            DateFormat().add_jm().format(
                                DateTime.parse(reservationModel.time)
                                    .add(const Duration(minutes: 2))),
                            style: TextStyle(
                                fontSize: 40,
                                color: textBold,
                                fontWeight: FontWeight.w900)),
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
                        // LargeButton(
                        //     text: "Cancelar",
                        //     isWhite: true,
                        //     onTap: () {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) =>
                        //               const ReservaConfirmadaScreen()));
                        //     }),
                        // SizedBox(
                        //   height: height / 15,
                        // ),
                        LargeButton(
                            text: "Ver mis reservas",
                            isWhite: false,
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                HomeBloc(context),
                                            child: const HomeScreen(
                                              index: 1,
                                            ),
                                          )),
                                  ModalRoute.withName('/'));
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
