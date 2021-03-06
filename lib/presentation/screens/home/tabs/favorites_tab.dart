import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/home/tabs/widgets/resuturants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavTab extends StatefulWidget {
  final List<RestaurantModel> favRestaurant;
  const FavTab({Key? key, required this.favRestaurant}) : super(key: key);

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  int currentFiler = 0;
  late bool _isSearching;
  String _searchText = "";
  List searchresult = [];

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
  User user = User();

  @override
  void initState() {
    _isSearching = false;
    super.initState();
    // populateDat();
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
    for (int i = 0; i < widget.favRestaurant.length; i++) {
      if (widget.favRestaurant[i].favorite != 1) {
        widget.favRestaurant.remove(widget.favRestaurant[i]);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                              child: TextField(
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.search,
                                  onChanged: (value) => searchOperation(value),
                                  decoration: const InputDecoration(
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
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: RestaurantesWidget(
            restaurantes: _isSearching ? searchresult : widget.favRestaurant,
          ),
        ))
      ]),
    );
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    _handleSearchStart();
    if (_isSearching != null) {
      for (int i = 0; i < widget.favRestaurant.length; i++) {
        String? data = widget.favRestaurant[i].name;
        if (data!.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(widget.favRestaurant[i]);
        }
      }
    }
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }
}
