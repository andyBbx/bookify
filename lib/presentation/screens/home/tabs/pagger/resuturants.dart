import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/widgets/resturants_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class Restaurantes extends StatelessWidget {
  Restaurantes({Key? key}) : super(key: key);

  final List<ReturantData> _resturants = [
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
        adress: "Barrio Leguina, s/n, 48195 \nLarrabetzu, Biscay, España",
        stars: 5,
        logo: "assets/images/resturant_logo2.png",
        images: ["assets/images/resturant2.png"],
        isFavv: true,
        description: "Cocina vasca de autor"),
  ];

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                child: Text(
                  "Restaurantes",
                  style: TextStyle(
                      color: textDrkgray,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Text(
                  "para ti",
                  style: TextStyle(
                      color: textDrkgray,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        GridView.count(
          crossAxisCount: isTab() ? 2 : 1,
          shrinkWrap: true,
          childAspectRatio: isTab() ? 2.5 : 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ResturantListItem(restaurante: _resturants[0]),
            ResturantListItem(restaurante: _resturants[1]),
            ResturantListItem(restaurante: _resturants[2]),
            ResturantListItem(restaurante: _resturants[1]),
          ],
        ),
      ],
    );
  }
}
