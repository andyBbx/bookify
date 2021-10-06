import 'dart:developer';

import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/screens/verificar_reserv_screen.dart';
import 'package:bookify/presentation/widgets/filter_chip.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

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

  ScrollController _scrollController = ScrollController();

  double radius = 60;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);

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

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    final List<Map> myProducts =
        List.generate(4, (index) => {"id": index, "name": "Product $index"})
            .toList();

    int count = 3;

    final List<String> times = [
      "10:30",
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
            leading: Icon(Icons.keyboard_arrow_left, color: Colors.white),

            actions: [
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
            flexibleSpace: Container(
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
                          Container(
                        child: Image.asset(
                          widget.restaurante.images[0],
                          fit: BoxFit.cover,
                        ),
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
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: CircleAvatar(
                        radius:
                            radius, // (70-_scrollController.position.pixels)>0?(70-_scrollController.position.pixels):70-_scrollController.position.pixels:10

                        backgroundColor: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2), // Shadow position
                              ),
                            ],
                            image: DecorationImage(
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
                SizedBox(
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
                SizedBox(
                  height: 20,
                ),
                RatingBarIndicator(
                  rating: 5,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: textBold,
                  ),
                  itemCount: 5,
                  itemSize: 30.0,
                  direction: Axis.horizontal,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
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
                SizedBox(
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
                    SizedBox(
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
                            SvgPicture.asset("assets/images/icons/world.svg"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
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
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
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
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
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
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 45,
                        decoration: BoxDecoration(
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
                                setState(() {
                                  count--;

                                  print("count " + count.toString());
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${count.toString()}",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: textDrkgray),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () {
                                count++;
                                print("count " + count.toString());
                                setState(() {});
                              },
                              icon: Icon(
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
                SizedBox(
                  height: 30,
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
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          // DatePicker.showDatePicker(context,
                          //     showTitleActions: true,
                          //     minTime: DateTime(2021, 9, 29),
                          //     maxTime: DateTime(2021, 10, 29),
                          //     theme: DatePickerTheme(
                          //         backgroundColor: Colors.white,
                          //         itemStyle: TextStyle(color: textDrkgray),
                          //         doneStyle: TextStyle(color: textBold)),
                          //     onChanged: (date) {
                          //   print('change $date');
                          // }, onConfirm: (date) {
                          //   print('confirm $date');
                          // },
                          //     currentTime: DateTime.now(),
                          //     locale: LocaleType.en);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                          decoration: BoxDecoration(
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
                                "07 / 09 / 21",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: textDrkgray.withOpacity(0.45)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  width: widhth,
                  color: devicerColor,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: List.generate(times.length, (index) {
                            return FilterChipItem(
                              cheapItem: CheapItem(
                                  text: times[index],
                                  icon: "icon",
                                  seleted: selextedIndex == index),
                              func: () {
                                setState(() {
                                  selextedIndex = index;
                                  print("selected " + selextedIndex.toString());
                                });
                              },
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
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  width: widhth,
                  color: devicerColor,
                ),
                SizedBox(
                  height: 30,
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
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: widhth,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Escribe aquí",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: textDrkgray),
                    ),
                  ),
                ),
                SizedBox(
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
                    SizedBox(
                      width: 30,
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
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
