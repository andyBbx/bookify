import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/error_widget.dart';
import 'package:bookify/presentation/widgets/resturants_list.dart';
import 'package:flutter/material.dart';

class RestaurantesWidget extends StatelessWidget {
  final dynamic restaurantes;
  final bool nowActive;
  const RestaurantesWidget(
      {Key? key, required this.restaurantes, this.nowActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("Is: {$nowActive}");
    return restaurantes.length == 0
        ? const ErrorBlocWidget(errorText: 'No se encontraron restaurantes')
        : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: isTab() ? 2.0 : 2.0,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: isTab() ? 2 : 1,
            ),
            itemCount: restaurantes.length,
            itemBuilder: (BuildContext ctx, index) {
              return ResturantListItem(
                  nowActive: nowActive, restaurante: restaurantes[index]);
            });
  }
}
