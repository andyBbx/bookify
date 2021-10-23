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

class Restaurantes extends StatelessWidget {
  final String type;
  const Restaurantes({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget myRestaurants;
    switch (type) {
      case "all":
        myRestaurants = BlocProvider(
          create: (_) => RestaurantBloc(context)..add(LoadData()),
          child: BlocBuilder<RestaurantBloc, RestaurantState>(
            builder: (context, state) {
              if (state is RestaurantLoaded) {
                return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: isTab() ? 2.5 : 2.5,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: isTab() ? 2 : 1,
                    ),
                    itemCount: state.restaurants.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return ResturantListItem(
                          restaurante: state.restaurants[index]);
                    });
              } else if (state is RestaurantFail) {
                final rest = state.message;
                return ErrorBlocWidget(errorText: rest);
              } else if (state is RestaurantEmptyDB) {
                return const ErrorBlocWidget(
                    errorText: 'No se encontraron restaurantes');
              }
              return const LoadWidget();
            },
          ),
        );
        break;
      default:
        myRestaurants = BlocProvider(
          create: (_) => RestaurantBloc(context)..add(LoadFavData()),
          child: BlocBuilder<RestaurantBloc, RestaurantState>(
            builder: (context, state) {
              if (state is RestaurantFavLoaded) {
                return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: isTab() ? 2.5 : 2.5,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: isTab() ? 2 : 1,
                    ),
                    itemCount: state.restaurants.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return ResturantListItem(
                          restaurante: state.restaurants[index]);
                    });
              } else if (state is RestaurantFail) {
                final rest = state.message;
                return ErrorBlocWidget(errorText: rest);
              } else if (state is RestaurantEmptyDB) {
                return const ErrorBlocWidget(
                    errorText: 'No se encontraron restaurantes');
              }
              return const LoadWidget();
            },
          ),
        );
    }

    return myRestaurants;
  }
}
