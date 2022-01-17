import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/offer.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/restaurant_info/bloc/restaurant_info_bloc.dart';
import 'package:bookify/presentation/screens/restaurant_info/view/resutrant_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key, required this.offers, required this.user})
      : super(key: key);
  final dynamic offers;
  final User user;

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  bool loadingOffer = false;
  @override
  void initState() {
    super.initState();
  }

  loadOffer() {
    setState(() {
      loadingOffer = true;
    });
  }

  readyLoadingOffer() {
    setState(() {
      loadingOffer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
        GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: isTab() ? 2.5 : 2.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: isTab() ? 2 : 1,
            ),
            itemCount: widget.offers.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container()/* offer_itemCard(
                context,
                widhth,
                height,
                widget.offers[index],
                widget.user,
              ) */;
            })
      ],
    );
  }

  Widget offer_itemCard(context, widhth, height, offer, user) {
    return offer.image!.isEmpty
        ? Container()
        : Stack(
            children: [
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                onTap: () async {
                  if (loadingOffer) {
                    return;
                  }
                  if (offer.restaurantId != null) {
                    setState(() {
                      loadingOffer = true;
                    });
                    var restaurantModel =
                        await getRestaurantModel(user, offer.restaurantId);
                    if (restaurantModel.name != null) {
                      setState(() {
                        loadingOffer = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) =>
                                              HomeBloc(context),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              RestaurantInfoInfoBloc(context),
                                        ),
                                      ],
                                      child: ResturantSelectionScreen(
                                        restaurante: restaurantModel,
                                      ))));
                    }
                  } else if (offer.url != null) {
                    launchURL(offer.url!);
                  }
                },
                child: Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: widhth,
                  /* height: isTab() ? height / 7 : 50, */
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(offer.image!), fit: BoxFit.cover),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2), // Shadow position
                      ),
                    ],
                  ),
                ),
              ),
              loadingOffer
                  ? Container(
                      color: Colors.white.withOpacity(0.9),
                      child: Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Opacity(
                      opacity: 0,
                    )
            ],
          );
  }

  Future<RestaurantModel> getRestaurantModel(user, restId) async {
    var response = await getService('/restaurant/$restId/view', user.auth_key!);
    if (response['code'] == 401) {
      return RestaurantModel(
          tags: [], createdAt: DateTime.now(), updatedAt: DateTime.now());
    } else if (response['code'] == 200) {
      var jsonRest = jsonDecode(response['model']);
      var restModel = RestaurantModel.fromJson(jsonRest);

      return restModel;
    } else {
      return RestaurantModel(
          tags: [], createdAt: DateTime.now(), updatedAt: DateTime.now());
    }
  }
}
