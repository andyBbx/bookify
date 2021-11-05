import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/screens/restaurant/bloc/restaurant_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/error_widget.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/resturants_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantesWidget extends StatelessWidget {
  final dynamic restaurantes;
  const RestaurantesWidget({Key? key, required this.restaurantes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return restaurantes.length == 0
        ? ErrorBlocWidget(errorText: 'No se encontraron restaurantes')
        : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: isTab() ? 2.5 : 2.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: isTab() ? 2 : 1,
            ),
            itemCount: restaurantes.length,
            itemBuilder: (BuildContext ctx, index) {
              return ResturantListItem(restaurante: restaurantes[index]);
            });
  }
}
