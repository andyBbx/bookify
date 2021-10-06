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
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(0)),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Image.asset(
                              reservation.restaurantesData.logo,
                              fit: BoxFit.scaleDown,
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(reservation.restaurantesData.name,
                                    style: TextStyle(
                                      color: textDrkgray,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
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
                                SizedBox(
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
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/icons/calender.svg",
                                  fit: BoxFit.scaleDown,
                                  width: 20,
                                  color: textBold,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("${reservation.time.toString()}",
                                    style: TextStyle(
                                      color: textDrkgray,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/icons/clock.svg",
                                  fit: BoxFit.scaleDown,
                                  width: 20,
                                  color: textBold,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("${reservation.info.toString()}",
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
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: textBold,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Center(
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
