import 'package:bookify/presentation/screens/restaurant/bloc/restaurant_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantCardView extends StatefulWidget {
  RestaurantCardView({Key? key}) : super(key: key);

  @override
  _RestaurantCardViewState createState() => _RestaurantCardViewState();
}

class _RestaurantCardViewState extends State<RestaurantCardView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RestaurantBloc>(context).add(LoadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RestaurantBloc(context)..add(LoadData()),
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoaded) {
            final rest = state.restaurants.data;
            return ListView.builder(
              itemCount: rest.length,
              itemBuilder: (context, index) =>
                  ListTile(title: Text(rest[index].name)),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
