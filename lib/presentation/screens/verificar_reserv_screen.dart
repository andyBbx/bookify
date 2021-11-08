import 'dart:convert';

import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/restaurant_info/bloc/restaurant_info_bloc.dart';
import 'package:bookify/presentation/widgets/large_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'confirmando_screen.dart';
import 'home/bloc/home_bloc.dart';

class VerificarReservaScreen extends StatelessWidget {
  final ReservationModel reservationModel;
  const VerificarReservaScreen({Key? key, required this.reservationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool reservationLoad = false;

    User user = User();

    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));
      }
    });

    return BlocBuilder<RestaurantInfoInfoBloc, RestaurantInfoState>(
      builder: (context, state) {
        if (state is CreateReservationLoad) {
          reservationLoad = true;
        } else if (state is CreateReservationSuccess) {
          BlocProvider.of<HomeBloc>(context).add(LoadReservationData(
            user: user,
          ));
          reservationLoad = false;
          return ConfirmandoScreen(
            reservationModel: reservationModel,
          );
        } else if (state is CreateReservationRestaurantFail) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message.toString())));
        }
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text("Confirmar reservación",
                  style: TextStyle(
                      fontSize: 15,
                      color: textDrkgray,
                      fontWeight: FontWeight.w700)),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  "assets/images/frame_confermation.png",
                ),
              )),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        reservationModel.restaurantData.cover == null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                // backgroundImage: AssetImage(
                                //   "assets/images/resutrant_logo1.png",
                                // ),
                                child: logo(250),
                              )
                            : const CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  "assets/images/resutrant_logo1.png",
                                ),
                              ),
                        Text(reservationModel.restaurantData.name,
                            style: TextStyle(
                                fontSize: 24,
                                color: textDrkgray,
                                fontWeight: FontWeight.w700)),
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
                            Text(reservationModel.restaurantData.address,
                                style: TextStyle(
                                  color: textDrkgray,
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
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
                        Text(" ${reservationModel.quantity} Personas",
                            style: TextStyle(
                                fontSize: 17,
                                color: textBold,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            " ${DateFormat.yMMMMd('en_US').format(reservationModel.date)}",
                            style: TextStyle(
                                fontSize: 17,
                                color: textBold,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Con horario de las ",
                            style: TextStyle(
                                fontSize: 17,
                                color: textDrkgray,
                                fontWeight: FontWeight.w100)),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                            DateFormat()
                                .add_jm()
                                .format(DateTime.parse(reservationModel.time))
                                .toString(),
                            style: TextStyle(
                                fontSize: 17,
                                color: textBold,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      width: widhth,
                      height: 1,
                      color: textDrkgray.withOpacity(0.3),
                    ),
                    const SizedBox(
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
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
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
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                            width: widhth / 2.5,
                            child: reservationLoad
                                ? Center(child: CircularProgressIndicator())
                                : LargeButton2(
                                    text: "Aceptar",
                                    isRed: false,
                                    onTap: () {
                                      BlocProvider.of<RestaurantInfoInfoBloc>(
                                              context)
                                          .add(CreateReservation(
                                        reservationModel: reservationModel,
                                        user: user,
                                      ));
                                    })),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
