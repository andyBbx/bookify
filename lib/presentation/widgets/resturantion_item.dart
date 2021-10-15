import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/reservation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResturantionItem extends StatelessWidget {
  const ResturantionItem({Key? key, required this.reservation})
      : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

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
                            child: Image.asset(
                              reservation.restaurantesData.cover,
                              fit: BoxFit.scaleDown,
                            ),
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
                              child: Text(reservation.restaurantesData.name,
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
                              rating: 5,
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
                                Text(
                                    "${reservation.person.toString()} Personas",
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
                                  child: Text(reservation.time.toString(),
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
                                Text(reservation.info.toString(),
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
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: textBold,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            restaurant: reservation.restaurantesData,
                          );
                        });
                  },
                  child: const Center(
                    child: Text(
                      "Calificar",
                      style: TextStyle(
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

  const CustomDialogBox({Key? key, required this.restaurant}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
              // Text(
              //   widget.descriptions,
              //   style: TextStyle(fontSize: 14),
              //   textAlign: TextAlign.center,
              // ),
              RatingBar.builder(
                onRatingUpdate: (value) {},
                initialRating: 0,
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
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2), // Shadow position
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage(
                      widget.restaurant.logo,
                    )),
              ),
            ),
            // child: ClipRRect(
            //     borderRadius: const BorderRadius.all(Radius.circular(20)),
            //     child: Image.asset(widget.img.toString())),
          ),
        ),
      ],
    );
  }
}
