import 'dart:developer';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/screens/verificar_reserv_screen.dart';
import 'package:bookify/presentation/widgets/filter_chip.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';

class ResturantSelectionScreen extends StatefulWidget {
  const ResturantSelectionScreen({Key? key, required this.restaurante})
      : super(key: key);
  final ReturantData restaurante;

  @override
  State<ResturantSelectionScreen> createState() =>
      _ResturantSelectionScreenState();
}

class _ResturantSelectionScreenState extends State<ResturantSelectionScreen> {
  int selextedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  double radius = 60;

  // final String dateReservation = DateTime.now().toString();
  var tempDate = Jiffy(DateTime.now()).dateTime;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 150) {
        setState(() {
          radius = 60;
        });
      } else if (_scrollController.position.pixels < 200) {
        setState(() {
          radius = 40;
        });
      } else if (_scrollController.position.pixels < 400) {
        setState(() {
          radius = 20;
        });
      }

      // if (_scrollController.position.pixels < 100 && radius == 0) {
      //   setState(() {
      //     radius = 60;
      //   });
      // } else if (_scrollController.position.pixels > 150 && radius != 0) {
      //   setState(() {
      //     radius = 0.0;
      //   });
      // }
    });
  }

  int count = 3;

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    final List<String> times = [
      "10:20",
      "15:00",
      "16:00",
      "17:00",
      "18:00",
      "19:00",
      "20:00",
      "21:00",
      "22:00",
      "23:00"
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            // leading: const Icon(Icons.keyboard_arrow_left, color: Colors.white),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            actions: const [
              Icon(Icons.favorite_border, color: Colors.white),
              SizedBox(
                width: 20,
              ),
            ],
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 320,
            collapsedHeight: 60,
            // toolBarColor: Colors.transparent,
            flexibleSpace: SizedBox(
              width: widhth,
              height: 350,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: CarouselSlider.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Image.asset(
                        widget.restaurante.images[0],
                        fit: BoxFit.cover,
                      ),
                      options: CarouselOptions(
                        autoPlay: true,
                        // enlargeCenterPage: true,
                        viewportFraction: 1,
                        aspectRatio: 1.4,
                        initialPage: 1,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 0,
                      left: 0,
                      child: CircleAvatar(
                        radius: radius,
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
                                  widget.restaurante.logo,
                                )),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.restaurante.name,
                  style: TextStyle(
                    fontSize: 25,
                    color: textDrkgray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.restaurante.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textDrkgray.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                    Text(widget.restaurante.adress,
                        style: TextStyle(
                          color: textDrkgray,
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Ver dirección",
                  style: TextStyle(
                      fontSize: 15,
                      color: textBold,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
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
                      ),
                      child: Center(
                        child:
                            SvgPicture.asset("assets/images/icons/world.svg"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                            "assets/images/icons/facebook.svg"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                      ),
                      child: Center(
                        child:
                            SvgPicture.asset("assets/images/icons/phone2.svg"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                            "assets/images/icons/instagram.svg"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Reserva ahora",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: textDrkgray),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Personas",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: textDrkgray),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.remove,
                                color: textDrkgray.withOpacity(0.45),
                              ),
                              onTap: () {
                                if (count >= 2) {
                                  count--;
                                  setState(() {});
                                }
                              },
                            ),
                            const SizedBox(
                              width: 17,
                            ),
                            Text(
                              count.toString(),
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: textDrkgray),
                            ),
                            const SizedBox(
                              width: 17,
                            ),
                            InkWell(
                              onTap: () {
                                count++;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.add,
                                color: textDrkgray.withOpacity(0.45),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  width: widhth,
                  color: devicerColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Fecha",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: textDrkgray),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2021, 9, 29),
                              maxTime:
                                  DateTime(DateTime.now().year + 1, 12, 31),
                              theme: DatePickerTheme(
                                  backgroundColor: Colors.white,
                                  itemStyle: TextStyle(color: textDrkgray),
                                  doneStyle: TextStyle(color: textBold)),
                              onConfirm: (date) {
                            setState(() {
                              tempDate = date;
                            });
                          }, currentTime: tempDate, locale: LocaleType.en);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2), // Shadow position
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                Jiffy(tempDate).format("dd / MM / yy"),
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: textDrkgray),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  width: widhth,
                  color: devicerColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: widhth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Horario",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: textDrkgray),
                      ),
                      GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: !isTab() ? 3 : 4,
                          childAspectRatio: !isTab() ? 3 : 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: List.generate(times.length, (index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  color: selextedIndex == index
                                      ? textBold
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                    color: textBold,
                                  )),
                              child: InkWell(
                                onTap: () {
                                  selextedIndex = index;
                                  print("selected " + selextedIndex.toString());
                                  setState(() {});
                                },
                                child: FilterChipHour(
                                  cheapItem: CheapItem(
                                      text: times[index],
                                      icon: "icon",
                                      seleted: selextedIndex == index
                                          ? true
                                          : false),
                                ),
                              ),
                            );
                          })),
                      // Container(
                      //   width: widhth,
                      //   height: 100,
                      //   child: SingleChildScrollView(
                      //     child: Column(
                      //       children: List.generate(3, (index) {
                      //         return Container(
                      //             padding: EdgeInsets.symmetric(vertical: 5),
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceEvenly,
                      //               children: [
                      //                 SizedBox(
                      //                   height: 40,
                      //                   child: FilterChipItem(
                      //                     cheapItem: CheapItem(
                      //                         text: times[index],
                      //                         icon: "icon",
                      //                         seleted: index == 0),
                      //                     func: () {
                      //                       selextedIndex = index;
                      //                     },
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 40,
                      //                   child: FilterChipItem(
                      //                     cheapItem: CheapItem(
                      //                         text: times[index + 1],
                      //                         icon: "icon",
                      //                         seleted: false),
                      //                     func: () {
                      //                       selextedIndex = index + 1;
                      //                     },
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 40,
                      //                   child: FilterChipItem(
                      //                     cheapItem: CheapItem(
                      //                         text: times[index + 2],
                      //                         icon: "icon",
                      //                         seleted: false),
                      //                     func: () {
                      //                       selextedIndex = index + 2;
                      //                     },
                      //                   ),
                      //                 ),
                      //               ],
                      //             ));
                      //       }),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  width: widhth,
                  color: devicerColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: widhth,
                  child: Text(
                    "Intolerancias ó alergias",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: textDrkgray),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: widhth,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: const TextField(
                      // textAlignVertical: TextAlignVertical.top,
                      textInputAction: TextInputAction.done,
                      maxLines: 4,
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: 'Escribe aqui...'
                          // label: Text(
                          //   'Escribe aqui...',
                          // )
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: widhth / 2.5,
                        child: LargeButton(
                            text: "Cancelar",
                            isWhite: true,
                            onTap: () {
                              Navigator.of(context).pop();
                            })),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        width: widhth / 2.5,
                        child: LargeButton(
                            text: "Aceptar",
                            isWhite: false,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      VerificarReservaScreen()));
                            })),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
