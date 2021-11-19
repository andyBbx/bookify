import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/reservation.dart';
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

class ResturantionItem extends StatelessWidget {
  const ResturantionItem(
      {Key? key, required this.reservation, required this.history})
      : super(key: key);

  final ReservationModel reservation;
  final bool history;

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;

    RestaurantModel restaurantData =
        RestaurantModel.fromJson(reservation.restaurantData);

    Color? colorStatus;

    String textStatus;

    Function() functionStatus = () {};

    reservation.status = 2;

    switch (reservation.status) {
      case 1:
        colorStatus = Colors.yellow[700];
        textStatus = 'Espera de confirmación';
        break;
      case 2:
        if (history) {
          colorStatus = textBold;
          textStatus = 'Calificar';
          functionStatus = () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BlocProvider(
                    create: (context) => HomeBloc(context),
                    child: CustomDialogBox(
                        restaurant: restaurantData, reservation: reservation),
                  );
                });
          };
        } else {
          colorStatus = Colors.green;
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
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(3, 3), // Shadow position
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: widhth,
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.02),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(0)),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: logo(100),
                          )),
                    ),
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
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            RatingBarIndicator(
                              rating: double.parse(
                                  restaurantData.rating.toString()),
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
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: colorStatus,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(15),
                      bottomRight:
                          Radius.circular(reservation.status == 1 ? 15 : 15),
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
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDialogBox extends StatefulWidget {
  final dynamic restaurant;
  final ReservationModel reservation;

  const CustomDialogBox(
      {Key? key, required this.restaurant, required this.reservation})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  User user = User();

  @override
  void initState() {
    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        setState(() {
          user = user.fromJson(jsonDecode(userModelString!));
        });
        if ((user.id)!.isEmpty) {
          //logout;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: isTab() ? MediaQuery.of(context).size.width / 4 : 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
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
                'Califica a ${widget.restaurant.name}',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              RatingBar.builder(
                onRatingUpdate: (value) {
                  setState(() {
                    widget.reservation.rated = value.toString();
                  });
                },
                initialRating: double.parse(widget.reservation.rated!),
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
                child: FlatButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(EditReservation(
                          reservationModel: widget.reservation, user: user));
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
          child: widget.restaurant.cover == null
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
        ),
      ],
    );
  }
}
