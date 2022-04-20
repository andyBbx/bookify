import 'dart:convert';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/owned_restaurant.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/booking_requests/booking_requests_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/CurrentRestaurant/bloc/current_restaurant_bloc.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/bloc/owned_restaurants_bloc.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/table_item_card.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/view/owned_restaurant_details.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/large_button.dart';
import 'package:bookify/presentation/widgets/resturants_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class MyOwnedRestaurants extends StatefulWidget {
  const MyOwnedRestaurants({Key? key}) : super(key: key);

  @override
  _MyOwnedRestaurantsState createState() => _MyOwnedRestaurantsState();
}

class _MyOwnedRestaurantsState extends State<MyOwnedRestaurants> {
  String currentRestaurantId = "";
  CurrentRestaurantBloc currentRestaurantBloc = CurrentRestaurantBloc();

  List storedRestarantList = [];

  RestaurantModel rm = RestaurantModel(
      id: "id",
      logo: "",
      name: "name",
      description: "description",
      phone: "phone",
      address: "address",
      postalCode: "postalCode",
      municipality: "municipality",
      province: "province",
      country: "country",
      latitude: "latitude",
      longitude: "longitude",
      web: "web",
      tags: ["tags"],
      status: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      favorite: 0,
      rating: "4.5",
      schedule: []);

  Widget tableListDialog() {
    return SizedBox(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          _confirmExchange() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Intercambiar mesa'),
                    content: Text(
                        '¿Estás seguro de que quieres intercambiar con la mesa $index?'),
                    actions: [
                      TextButton(
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "Sí, intercambiar mesa",
                        ),
                        onPressed: () {},
                      ),
                    ],
                  );
                });
          }

          return Container(
              child: InkWell(
                onTap: _confirmExchange,
                child: ListTile(title: Text('Mesa $index - (2 personas)')),
              ),
              decoration:
                  const BoxDecoration(border: Border(bottom: BorderSide())));
        },
      ),
    );
  }

  Widget newTableDialog() {
    return SizedBox(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView(
          children: [
            Image.asset(
              "assets/table.png",
              height: 90,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: splash_background),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: splash_background),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: splash_background),
                ),
                fillColor: Colors.red,
                hintText: "Nombre de la mesa",
                label: Text("Nombre de la mesa",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 11, color: textDrkgray)),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: splash_background),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: splash_background),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: splash_background),
                ),
                fillColor: Colors.red,
                hintText: "Número de personas",
                label: Text("Número de personas",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 11, color: textDrkgray)),
              ),
            ),
            const SizedBox(height: 25),
            LargeButton(
                text: "Crear mesa",
                isWhite: true,
                onTap: () {
                  // if ()
                  // Navigator.of(context).pop();
                })
          ],
        ));
  }

  _addNewTable(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Crear nueva mesa'),
            content: newTableDialog(),
            actions: [
              TextButton(
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget restaurantsListItems(restaurantlist, myContext) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        itemCount: restaurantlist.length,
        itemBuilder: (listContext, index) {
          OwnedRestaurantModel restaurant = restaurantlist[index];
          return Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<OwnedRestaurantsBloc>(context),
                    child: OwnedRestaurantDetails(
                      restaurante: restaurant,
                    ),
                  ),
                ));
              },
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: DecorationImage(
                              image: (restaurant.logo).isNotEmpty
                                  ? NetworkImage(restaurant.logo)
                                  : const AssetImage("assets/halfPattern.png")
                                      as ImageProvider, // <-- BACKGROUND IMAGE
                              fit: BoxFit.cover,
                            ),
                          ),
                        ), /* state.restaurants[index].name.isNotEmpty
                                            ? Image.network(
                                                state.restaurants[index].logo)
                                            : logo(250) */
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(restaurantlist[index].name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: textDrkgray,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                    ],
                                  ),
                                  RatingBarIndicator(
                                    rating: double.parse(
                                        restaurant.rating.toString()),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/icons/location.svg",
                                    fit: BoxFit.scaleDown,
                                    width: 12,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(restaurant.address,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: textDrkgray,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ),
                                ],
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Text(restaurant.description,
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        /* BlocProvider.of<BookingRequestsBloc>(
                                              myContext)
                                          .add(LoadUnconfirmedBookings(
                                              restaurantId: restaurant.id)); */
                        BlocProvider.of<BookingRequestsBloc>(myContext).add(
                            LoadUnconfirmedBookings(
                                restaurantId: restaurant.id));
                        BlocProvider.of<BookingsBloc>(myContext).add(
                            LoadConfirmedBookings(restaurantId: restaurant.id));
                        BlocProvider.of<TablesBloc>(myContext).add(
                            LoadRestaurantTables(restaurantId: restaurant.id));
                        BlocProvider.of<BookingsBloc>(myContext).add(
                            LoadConfirmedBookings(restaurantId: restaurant.id));
                        BlocProvider.of<CurrentRestaurantBloc>(myContext)
                            .add(SetCurrentRestaurant(restaurant: restaurant));
                        setState(() {
                          currentRestaurantId = restaurant.id;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Icon(
                          Icons.check_box,
                          color: currentRestaurantId == restaurant.id
                              ? Colors.orange
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext myContext) {
    currentRestaurantBloc = BlocProvider.of(myContext);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(myContext).push(MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<OwnedRestaurantsBloc>(myContext),
              child: OwnedRestaurantDetails(
                restaurante: OwnedRestaurantModel(
                    id: "",
                    logo: "",
                    name: "",
                    description: "",
                    phone: "",
                    address: "",
                    postalCode: "",
                    municipality: "",
                    province: "",
                    country: "",
                    web: "",
                    rating: "",
                    latitude: "",
                    longitude: "",
                    menuUrl: ""),
              ),
            ),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 29,
        ),
        backgroundColor: Colors.orange,
        tooltip: 'Agregar nueva mesa',
        elevation: 5,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            BlocBuilder<CurrentRestaurantBloc, CurrentRestaurantState>(
                bloc: currentRestaurantBloc,
                builder: (context, state) {
                  if (state is SettingCurrentRestaurant) {
                    return RestaurantHeader(
                      title: "Mis Restaurantes",
                      subtitle: "...",
                    );
                  } else if (state is DoneSettingCurrentRestaurant) {
                    if (currentRestaurantId.isEmpty) {
                      currentRestaurantId = state.restaurant.id;
                    }

                    return RestaurantHeader(
                      title: "Mis Restaurantes",
                      subtitle:
                          "Restaurante seleccionado: ${state.restaurant.name}",
                    );
                  } else {
                    return RestaurantHeader(
                      title: "Mis Restaurantes",
                      subtitle:
                          "Selecciona un restaurante para poder gestionar sus reservas, solicitudes, etc.",
                    );
                  }
                }),
            BlocBuilder<OwnedRestaurantsBloc, OwnedRestaurantsState>(
              builder: (context, state) {
                if (state is FailedLoadingOwnedRestaurants) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (state is LoadingOwnedRestaurants) {
                  return const Expanded(child: LoadWidget());
                } else if (state is ReadyOwnedRestaurants) {
                  if (state.restaurants.isEmpty) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                                "Aún no tienes ningún restaurante registrado"),
                            const SizedBox(
                              height: 10,
                            ),
                            LargeButton(
                                text: "Registra tu restaurante",
                                isWhite: false,
                                onTap: () {
                                  Navigator.of(myContext)
                                      .push(MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value:
                                          BlocProvider.of<OwnedRestaurantsBloc>(
                                              myContext),
                                      child: OwnedRestaurantDetails(
                                        restaurante: OwnedRestaurantModel(
                                            id: "",
                                            logo: "",
                                            name: "",
                                            description: "",
                                            phone: "",
                                            address: "",
                                            postalCode: "",
                                            municipality: "",
                                            province: "",
                                            country: "",
                                            web: "",
                                            rating: "",
                                            latitude: "",
                                            longitude: "",
                                            menuUrl: ""),
                                      ),
                                    ),
                                  ));
                                })
                          ],
                        ),
                      ),
                    );
                  }

                  storedRestarantList = state.restaurants;
                  return restaurantsListItems(storedRestarantList, myContext);
                } else {
                  if (storedRestarantList.isNotEmpty) {
                    return restaurantsListItems(storedRestarantList, myContext);
                  }
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Error para cargar los restaurantes'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
