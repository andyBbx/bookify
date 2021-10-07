import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  const Offers({Key? key}) : super(key: key);

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
              Text(
                "Ofertas",
                style: TextStyle(
                    color: textDrkgray,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Lo mejor para ti",
                style: TextStyle(
                    color: textDrkgray,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          crossAxisCount: isTab() ? 2 : 1,
          shrinkWrap: true,
          childAspectRatio: isTab() ? 2.5 : 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            offer_itemCard(
              widhth: widhth,
              height: height,
              text1: "Solo por hoy",
              text2: "45% off",
              text3: "En JB´s Burguers",
              text4: "*Aplican restricciones",
              isWhite: false,
              image: "assets/buger.png",
            ),
            offer_itemCard(
              widhth: widhth,
              height: height,
              text1: "Solo por hoy",
              text2: "45% off",
              text3: "En JB´s Burguers",
              text4: "*Aplican restricciones",
              isWhite: true,
              image: "assets/hasta.png",
            ),
            offer_itemCard(
              widhth: widhth,
              height: height,
              text1: "Solo por hoy",
              text2: "45% off",
              text3: "En JB´s Burguers",
              text4: "*Aplican restricciones",
              isWhite: true,
              image: "assets/buger.png",
            ),
            offer_itemCard(
              widhth: widhth,
              height: height,
              text1: "Solo por hoy",
              text2: "45% off",
              text3: "En JB´s Burguers",
              text4: "*Aplican restricciones",
              isWhite: false,
              image: "assets/buger.png",
            ),
            offer_itemCard(
              widhth: widhth,
              height: height,
              text1: "Solo por hoy",
              text2: "45% off",
              text3: "En JB´s Burguers",
              text4: "*Aplican restricciones",
              isWhite: false,
              image: "assets/buger.png",
            ),
            offer_itemCard(
              widhth: widhth,
              height: height,
              text1: "Solo por hoy",
              text2: "45% off",
              text3: "En JB´s Burguers",
              text4: "*Aplican restricciones",
              isWhite: true,
              image: "assets/buger.png",
            ),
            offer_itemCard(
              widhth: widhth,
              height: height,
              text1: "Solo por hoy",
              text2: "45% off",
              text3: "En JB´s Burguers",
              text4: "*Aplican restricciones",
              isWhite: false,
              image: "assets/buger.png",
            ),
            offer_itemCard(
              widhth: widhth,
              height: height,
              text1: "Solo por hoy",
              text2: "45% off",
              text3: "En JB´s Burguers",
              text4: "*Aplican restricciones",
              isWhite: false,
              image: "assets/buger.png",
            ),
          ],
        ),
      ],
    );
  }
}

class offer_itemCard extends StatelessWidget {
  const offer_itemCard({
    Key? key,
    required this.widhth,
    required this.height,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    this.image,
    required this.isWhite,
  }) : super(key: key);

  final double widhth;
  final double height;
  final String text1, text2, text3, text4;
  final image;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      width: widhth,
      height: isTab() ? height / 7 : 50,
      decoration: isWhite
          ? const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2), // Shadow position
                ),
              ],
            )
          : BoxDecoration(
              gradient: appgradient,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2), // Shadow position
                ),
              ],
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: widhth / 15,
          ),
          Expanded(
            flex: isTab() ? 1 : 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$text1",
                    style: TextStyle(
                      color: isWhite ? textDrkgray : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
                Text("$text2",
                    style: TextStyle(
                      color: isWhite ? textDrkgray : Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    )),
                Text(text3,
                    style: TextStyle(
                      color: isWhite ? textDrkgray : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
                Text("$text4",
                    style: TextStyle(
                      color: isWhite ? textDrkgray : Colors.white,
                      fontSize: 6,
                      fontWeight: FontWeight.normal,
                    )),
              ],
            ),
          ),
          Expanded(
            flex: isTab() ? 1 : 3,
            child: Image.asset(
              "$image",
            ),
          )
        ],
      ),
    );
  }
}
