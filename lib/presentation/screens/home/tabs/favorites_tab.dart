import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:bookify/logics/cubit/signup_cubit.dart';
import 'package:bookify/presentation/screens/home/tabs/pagger/resuturants.dart';
import 'package:bookify/presentation/widgets/filter_chip.dart';
import 'package:bookify/presentation/widgets/reservar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'pagger/offers.dart';

class FavTab extends StatefulWidget {
  const FavTab({Key? key}) : super(key: key);

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  int currentFiler = 0;

  List<CheapItem> cheapitems = [
    CheapItem(
      text: "De Todo",
      icon: "assets/images/icons/sushi.svg",
      seleted: true,
    ),
  ];

  void populateDat() {
    cheapitems.clear();
    cheapitems.addAll([
      CheapItem(
        text: "De Todo",
        icon: "",
        seleted: currentFiler == 0,
      ),
      CheapItem(
        text: "Sushi",
        icon: "assets/images/icons/sushi.svg",
        seleted: currentFiler == 1,
      ),
      CheapItem(
        text: "Pizza",
        icon: "assets/images/icons/pizza.svg",
        seleted: currentFiler == 2,
      ),
      CheapItem(
        text: "Hamburguesa",
        icon: "assets/images/icons/one-hamburguer.svg",
        seleted: currentFiler == 3,
      ),
    ]);
  }

  bool nowActive = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // populateDat();
  }

  @override
  Widget build(BuildContext context) {
    populateDat();

    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            collapsedHeight: isTab() ? height / 7 : widhth / 3,
            backgroundColor: Colors.white,
            pinned: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: appgradient,
              ),
              width: widhth,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    "assets/images/reservation_topFrame.png",
                    width: widhth,
                    fit: BoxFit.cover,
                    color: frameColor.withOpacity(0.45),
                  ),
                ),
                // Positioned(
                //     top: 20,
                //     left: 20,
                //     child: SafeArea(
                //         child: Row(
                //       children: [
                //         Icon(
                //           Icons.keyboard_arrow_left,
                //           color: Colors.white,
                //           size: 30,
                //         ),
                //       ],
                //     ))),
                Positioned(
                  child: SafeArea(
                    child: SizedBox(
                      width: widhth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Mis favoritos",
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 250,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const TextField(
                                  decoration: InputDecoration(
                                hintText: "Buscar restaurante",
                                hintStyle: TextStyle(
                                  fontSize: 19,
                                ),
                                suffixIcon: Icon(
                                  Icons.search,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              )))
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            )),
        // SliverAppBar(
        //   pinned: true,
        //   iconTheme: const IconThemeData(
        //     color: Colors.transparent,
        //   ),
        //   expandedHeight: isTab() ? height / 7 : widhth / 1.7,
        //   collapsedHeight: isTab() ? height / 7 : widhth / 1.7,
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black12,
        //           blurRadius: 4,
        //           offset: Offset(2, 2), // Shadow position
        //         ),
        //       ],
        //     ),
        //     width: widhth,
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 10),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           BlocBuilder<SignupCubit, SignupState>(
        //             builder: (context, state) {
        //               return Text(
        //                 // "Hola, ${state}",
        //                 'Mis favoritos',
        //                 style: TextStyle(
        //                     fontSize: 29,
        //                     fontWeight: FontWeight.bold,
        //                     color: textDrkgray),
        //               );
        //             },
        //           ),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   width: 250,
        //   height: 50,
        //   decoration: BoxDecoration(
        //     color: backgroundColor,
        //     borderRadius: const BorderRadius.all(Radius.circular(10)),
        //   ),
        //   child: const TextField(
        //     decoration: InputDecoration(
        //       hintText: "Buscar restaurante",
        //       hintStyle: TextStyle(
        //         fontSize: 19,
        //       ),
        //       suffixIcon: Icon(
        //         Icons.search,
        //       ),
        //       enabledBorder: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.transparent),
        //       ),
        //       border: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.transparent),
        //       ),
        //       focusedBorder: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.transparent),
        //       ),
        //     ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(child: Restaurantes())
      ]),
    );
  }
}