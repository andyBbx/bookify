import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/screens/resutrant_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResturantListItem extends StatelessWidget {
  const ResturantListItem({Key? key, required this.restaurante})
      : super(key: key);

  final ReturantData restaurante;

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Stack(
      children: [
        InkWell(
          onTap: () {
            //RegisterScreen
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ResturantSelectionScreen(
                      restaurante: restaurante,
                    )));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: widhth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
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
                        restaurante.logo,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: isTab() ? 5 : 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(restaurante.name,
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/icons/location.svg",
                              fit: BoxFit.scaleDown,
                              width: 9,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(restaurante.adress,
                                  style: TextStyle(
                                    color: textDrkgray,
                                    fontSize: 9,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(restaurante.description,
                              style: TextStyle(
                                color: textDrkgray.withOpacity(0.5),
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 40,
          child: Icon(
            restaurante.isFavv ? Icons.favorite : Icons.favorite_outline,
            color: restaurante.isFavv ? favrioteColor : textDrkgray,
            size: 20,
          ),
        )
      ],
    );
  }
}
