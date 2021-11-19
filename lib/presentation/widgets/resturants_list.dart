import 'dart:convert';

import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/restaurant_info/bloc/restaurant_info_bloc.dart';
import 'package:bookify/presentation/screens/restaurant_info/view/resutrant_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResturantListItem extends StatefulWidget {
  const ResturantListItem({Key? key, required this.restaurante})
      : super(key: key);

  final RestaurantModel restaurante;

  @override
  State<ResturantListItem> createState() => _ResturantListItemState();
}

class _ResturantListItemState extends State<ResturantListItem> {
  User user = User();

  @override
  void initState() {
    super.initState();

    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;

    // return Text('ff');
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      width: widhth,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => HomeBloc(context),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  RestaurantInfoInfoBloc(context),
                            ),
                          ],
                          child: ResturantSelectionScreen(
                            restaurante: widget.restaurante,
                          ))));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: widget.restaurante.cover == null
                  ? logo(250)
                  : Image.asset(
                      widget.restaurante.cover,
                      fit: BoxFit.contain,
                    ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(widget.restaurante.name!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: textDrkgray,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.restaurante.favorite == 1) {
                                  //
                                  // setState(() {
                                  widget.restaurante.favorite = 0;
                                  // });
                                  BlocProvider.of<HomeBloc>(context).add(
                                      RemoveFavorite(
                                          restId: widget.restaurante.id!,
                                          user: user));
                                } else {
                                  // setState(() {
                                  widget.restaurante.favorite = 1;
                                  // });
                                  //
                                  BlocProvider.of<HomeBloc>(context).add(
                                      AddFavorite(
                                          restId: widget.restaurante.id!,
                                          user: user));
                                }
                              },
                              child: Icon(
                                widget.restaurante.favorite == 1
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: widget.restaurante.favorite == 1
                                    ? favrioteColor
                                    : textDrkgray,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        RatingBarIndicator(
                          rating: double.parse(
                              widget.restaurante.rating.toString()),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: textBold,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/images/icons/location.svg",
                          fit: BoxFit.scaleDown,
                          width: 9,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(widget.restaurante.address!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: textDrkgray,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Text(widget.restaurante.description!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: textDrkgray.withOpacity(0.5),
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
