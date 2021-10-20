import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/screens/restaurant/bloc/restaurant_bloc.dart';
import 'package:bookify/presentation/screens/restaurant/view/restaurant_view.dart';
import 'package:bookify/presentation/widgets/resturants_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Restaurantes extends StatelessWidget {
  Restaurantes({Key? key}) : super(key: key);

  // final List<ReturantData> _resturants = [
  //   ReturantData(
  //       name: "Restaurante japonés",
  //       adress: "C/ Sagasta 23. Madrid",
  //       stars: 5,
  //       images: ["assets/images/resrturant1.png"],
  //       logo: "assets/images/resutrant_logo1.png",
  //       isFavv: true,
  //       description: "Restaurante japonés de la más alta calidad."),
  //   ReturantData(
  //       name: "Ikigai",
  //       adress: "C/ Flor Baja, 5. Madrid",
  //       stars: 5,
  //       logo: "assets/images/resturant_logo3.png",
  //       isFavv: false,
  //       images: ["assets/images/resturant2.png"],
  //       description:
  //           "Restaurante especializado en cocina japonesa de alta calidad."),
  //   ReturantData(
  //       name: "Azurmendi",
  //       adress: "Barrio Leguina, s/n, 48195 \nLarrabetzu, Biscay, España",
  //       stars: 5,
  //       logo: "assets/images/resturant_logo2.png",
  //       images: ["assets/images/resturant2.png"],
  //       isFavv: true,
  //       description: "Cocina vasca de autor"),
  // ];

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return BlocProvider(
      create: (_) => RestaurantBloc(context)..add(LoadData()),
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoaded) {
            // ListView.builder(itemBuilder: itemBuilder)
            final rest = state.restaurants.data;
            // return ResturantListItem(restaurante: rest[0]);
            // retrun ResturantListItem(restaurante: rest[index]);
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
                itemCount: rest.length,
                itemBuilder: (BuildContext ctx, index) {
                  return ResturantListItem(restaurante: rest[index]);
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
    // return Column(
    //   children: [
    //     GridView.count(
    // padding: const EdgeInsets.symmetric(horizontal: 20),
    // crossAxisCount: isTab() ? 2 : 1,
    // shrinkWrap: true,
    // childAspectRatio: isTab() ? 2.5 : 2,
    // crossAxisSpacing: 20,
    // mainAxisSpacing: 20,
    //       physics: const NeverScrollableScrollPhysics(),
    //       children: [

    //         // ResturantListItem(restaurante: _resturants[0]),
    //         // ResturantListItem(restaurante: _resturants[1]),
    //         // ResturantListItem(restaurante: _resturants[2]),
    //         // ResturantListItem(restaurante: _resturants[1]),
    //       ],
    //     ),
    //   ],
    // );
  }
}
