import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

Widget resturantionItem(context, reservation, history) {
  double widhth = MediaQuery.of(context).size.width;

  RestaurantModel restaurantData =
      RestaurantModel.fromJson(reservation.restaurantData);

  Color? colorStatus;

  String textStatus;

  User user = User();
  bool onError = false;

  Utils().startSharedPreferences().then((prefs) {
    String? userModelString = prefs.getString("user");
    if (Utils().checkJsonArray(userModelString)) {
      user = user.fromJson(jsonDecode(userModelString!));

      if ((user.id)!.isEmpty) {
        //logout;
      }
    }
  });

  Function() functionStatus = () {};

  switch (reservation.status) {
    case 1:
      if (history) {
        colorStatus = Colors.grey;
        textStatus = 'No confirmado';
      } else {
        colorStatus = Colors.grey;
        textStatus = 'Espera de confirmación';
      }
      break;
    case 2:
      if (history) {
        colorStatus = textBold;
        textStatus = 'Calificar';
        functionStatus = () {
          showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<HomeBloc>(context),
                  child: Dialog(
                      insetPadding: EdgeInsets.symmetric(
                          horizontal: isTab()
                              ? MediaQuery.of(context).size.width / 4
                              : 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: contentBox(context, reservation.restaurantData,
                          user, reservation))));
        };
      } else {
        colorStatus = Colors.green[400];
        textStatus = 'Confirmada';
      }
      break;
    case 3:
      colorStatus = Colors.red;
      textStatus = 'Cancelada';
      break;
    case 4:
      if (history) {
        colorStatus = textBold;
        textStatus = 'Calificar';
      } else {
        colorStatus = Colors.green;
        textStatus = 'Confirmada';
      }
      break;
    default:
      colorStatus = Colors.yellow[700];
      textStatus = 'Desconicido';
  }

  return Stack(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: widhth,
              height: reservation.rated == '0.00' ? 130 : 150,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(3, 3), // Shadow position
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft:
                          Radius.circular(reservation.rated == '0.00' ? 0 : 15),
                      bottomRight: Radius.circular(
                          reservation.rated == '0.00' ? 0 : 15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: restaurantData.logo == null || onError
                          ? logo(200)
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: onError
                                      ? null
                                      : DecorationImage(
                                          onError: (value, v) {
                                            onError = true;
                                          },
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              restaurantData.logo!)),
                                  /* borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)) */),
                              // child: Image.network(
                              //   widget.restaurante.logo!,
                              //   fit: BoxFit.cover,
                              // ),
                            )),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(restaurantData.name!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: textDrkgray,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          reservation.rated == '0.00'
                              ? Container()
                              : RatingBarIndicator(
                                  rating: double.parse(
                                      reservation.rated.toString()),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: textBold,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/icons/profile.svg",
                                fit: BoxFit.scaleDown,
                                width: 20,
                                color: textBold,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("${reservation.quantity} Personas",
                                  style: TextStyle(
                                    color: textDrkgray,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/images/icons/calender.svg",
                                fit: BoxFit.scaleDown,
                                width: 20,
                                color: textBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                    " ${DateFormat().add_MMMd().format(reservation.date)}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: textDrkgray,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/icons/clock.svg",
                                fit: BoxFit.scaleDown,
                                width: 20,
                                color: textBold,
                              ),
                              Text(
                                  " ${DateFormat().add_jm().format(DateTime.parse("2019-07-19 ${reservation.time}"))}",
                                  style: TextStyle(
                                    color: textDrkgray,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            reservation.rated != '0.00' && history
                ? Container()
                : history || reservation.status == 3
                    ? Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: colorStatus,
                            borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(15),
                              bottomRight: Radius.circular(
                                  reservation.status == 1 ? 15 : 15),
                            )),
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          onTap: functionStatus,
                          child: Center(
                            child: Text(
                              textStatus,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.red[700],
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    // bottomRight: Radius.circular(
                                    //     reservation.status == 1 ? 15 : 15),
                                  )),
                              child: InkWell(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<HomeBloc>(
                                              context),
                                          child: Dialog(
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: isTab()
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4
                                                          : 30),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              elevation: 0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: deleteBox(
                                                  context,
                                                  reservation.restaurantData,
                                                  user,
                                                  reservation))));
                                },
                                child: const Center(
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: colorStatus,
                                  borderRadius: BorderRadius.only(
                                    // bottomLeft: const Radius.circular(15),
                                    bottomRight: Radius.circular(
                                        reservation.status == 1 ? 15 : 15),
                                  )),
                              child: InkWell(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                onTap: functionStatus,
                                child: Center(
                                  child: Text(
                                    textStatus,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
          ],
        ),
      ),
    ],
  );
}

deleteBox(context, restaurant, user, reservation) {
  // bool load = false;
  // String rated = reservation.rated;
  // String rated = "0.00";
  return Stack(
    children: <Widget>[
      Container(
        padding:
            const EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 20),
        margin: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              '¿Desea cancelar su reservación?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 22,
            ),
            Align(
                alignment: Alignment.bottomRight,
                // ignore: deprecated_member_use
                child: InkWell(
                    onTap: () async {
                      reservation.status = 3;
                      BlocProvider.of<HomeBloc>(context).add(EditReservation(
                          user: user, reservationModel: reservation));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(fontSize: 15),
                    ))),
          ],
        ),
      ),
      Positioned(
        left: 20,
        right: 20,
        child: restaurant['logo'] == null
            ? CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                // backgroundImage: AssetImage(
                //   "assets/images/resutrant_logo1.png",
                // ),
                child: logo(250),
              )
            : CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  restaurant['logo'],
                ),
              ),
      ),
    ],
  );
}

contentBox(context, restaurant, user, reservation) {
  String rated = reservation.rated;
  // String rated = "0.00";
  return Stack(
    children: <Widget>[
      Container(
        padding:
            const EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 20),
        margin: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              rated != "0.00"
                  ? 'Ya has calificado a ${restaurant['name']}'
                  : 'Califica a ${restaurant['name']}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            rated != "0.00"
                ? RatingBarIndicator(
                    rating: double.parse(rated),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: splash_background,
                    ),
                  )
                : RatingBar.builder(
                    onRatingUpdate: (value) {
                      rated = value.toString();
                    },
                    initialRating: double.parse(rated),
                    itemSize: 35,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    unratedColor: Colors.grey.withOpacity(0.5),
                    glow: false,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: splash_background,
                    ),
                  ),
            const SizedBox(
              height: 22,
            ),
            Align(
              alignment: Alignment.bottomRight,
              // ignore: deprecated_member_use
              child: rated != "0.00"
                  ? InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cerrar',
                        style: TextStyle(fontSize: 15),
                      ))
                  : InkWell(
                      onTap: () async {
                        // Navigator.pop(context);
                        reservation.rated = rated;
                        BlocProvider.of<HomeBloc>(context).add(EditReservation(
                            user: user, reservationModel: reservation));
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Calificar',
                        style: TextStyle(fontSize: 15),
                      )),
            ),
          ],
        ),
      ),
      Positioned(
        left: 20,
        right: 20,
        child: restaurant['logo'] == null
            ? CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                // backgroundImage: AssetImage(
                //   "assets/images/resutrant_logo1.png",
                // ),
                child: logo(250),
              )
            : CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(restaurant['logo']),
              ),
      ),
    ],
  );
}
