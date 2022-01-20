import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:bookify/data/models/location.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/place_service.dart';
import 'package:bookify/logics/cubit/signup_cubit.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/home/tabs/widgets/offers.dart';
import 'package:bookify/presentation/screens/home/tabs/widgets/resuturants.dart';
import 'package:bookify/presentation/screens/search/bloc/search_bloc.dart';
import 'package:bookify/presentation/screens/search/view/search_page.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/error_widget.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/filter_chip.dart';
import 'package:bookify/presentation/widgets/no_data_yet.dart';
import 'package:bookify/presentation/widgets/reservar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeTab extends StatefulWidget {
  final User user;
  final dynamic categories;
  final dynamic restaurant;
  final dynamic restaurantCat;
  final List offers;
  const HomeTab(
      {Key? key,
      required this.user,
      required this.categories,
      required this.restaurant,
      this.restaurantCat,
      required this.offers})
      : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentFiler = 0;
  User user = User();
  Location location = Location();

  bool nowActive = false;

  @override
  void initState() {
    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        setState(() {
          user = user.fromJson(jsonDecode(userModelString!));
        });
        String? locationModel = prefs.getString("location");
        if (Utils().checkJsonArray(locationModel)) {
          location = location.fromJson(jsonDecode(locationModel!));
        }
        if ((user.id)!.isEmpty) {
          //logout;
        }
      }
    });

    super.initState();
    // populateDat();
  }

//   searchLoc() async {
//     // generate a new token here
//     // final sessionToken = Uuid().v4();
//     final Suggestion? result = await showSearch(
//       context: context,
//       delegate: AddressSearch(),
//     );
//     // This will change the text displayed in the TextField
//     if (result != null) {
//       setState(() {
//         String miDir = result.description;
//         // _controller.text = result.description;
//       });

//       final query = result.description;
//       var addresses = await Geolocation.local.findAddressesFromQuery(query);
//       var first = addresses.first;
//       print("${first.featureName} : ${first.coordinates.latitude}");
// // TODO: guardad lg y lat
//     }
//   }

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<RestaurantModel>? myRest = [];

    bool load = false;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is EstadoRestLoad) {
          // currentFiler = 0;
          load = false;
        } else if (state is EstadoRestLoading) {
          load = true;
        }

        return Scaffold(
            backgroundColor: backgroundColor,
            body: CustomScrollView(slivers: [
              SliverAppBar(
                stretch: false,
                // pinned: true,
                iconTheme: const IconThemeData(
                  color: Colors.transparent,
                ),
                expandedHeight: isTab() ? height / 7 : widhth / 1.7,
                collapsedHeight: isTab() ? height / 7 : widhth / 1.7,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2), // Shadow position
                      ),
                    ],
                  ),
                  width: widhth,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          right: isTab() ? widhth / -10 : widhth / -2,
                          child: SvgPicture.asset("assets/frame_hometab.svg")),
                      Positioned(
                          top: isTab() ? height / 15 : height / 11,
                          left: 20,
                          child: Flex(
                            direction:
                                isTab() ? Axis.horizontal : Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<SignupCubit, SignupState>(
                                    builder: (context, state) {
                                      return Text(
                                        // "Hola, ",
                                        'Hola, ' + user.firstname.toString(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: textDrkgray),
                                      );
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // generate a new token here
                                      // final sessionToken = Uuid().v4();
                                      final Suggestion? result =
                                          await showSearch(
                                        context: context,
                                        delegate: AddressSearch(),
                                      );
                                      // This will change the text displayed in the TextField
                                      if (result != null) {
                                        final placeDetails =
                                            await PlaceApiProvider('12345')
                                                .getPlaceDetailFromId(
                                                    result.placeId);
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(LoadData(user: user));
                                        setState(() {
                                          location = Location(
                                              adresss: placeDetails.city != null
                                                  ? "${placeDetails.street}, ${placeDetails.city}"
                                                  : placeDetails.street != null
                                                      ? "${placeDetails.street}"
                                                      : null,
                                              lat: placeDetails.long != null &&
                                                      placeDetails.lat != null
                                                  ? "${placeDetails.lat}"
                                                  : "",
                                              long: placeDetails.long != null &&
                                                      placeDetails.lat != null
                                                  ? "${placeDetails.long}"
                                                  : "");

                                          saveUserUbi(
                                              '{"adresss": "${placeDetails.city != null ? "${placeDetails.street}, ${placeDetails.city}" : placeDetails.street != null ? "${placeDetails.street}" : null}", "long": "${placeDetails.long}", "lat": "${placeDetails.lat}"}');
                                        });
                                      }
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/icons/location.svg",
                                            fit: BoxFit.scaleDown,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                                location.adresss == null
                                                    ? 'Escribe tu dirección'
                                                    : location.adresss!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: textDrkgray)),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.arrow_drop_down,
                                              color: splash_background)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              //   width: widhth / 3,
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: TextField(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) =>
                                                      SearchBloc(context),
                                                  child: SearchPage(
                                                    user: user,
                                                  ),
                                                )));
                                  },
                                  readOnly: true,
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
                                  ),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: widhth,
                      child: Text(
                        "Reservar",
                        style: TextStyle(
                            color: textDrkgray,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 120,
                              child: InkWell(
                                  onTap: () {
                                    if (!nowActive) {
                                      BlocProvider.of<HomeBloc>(context).add(
                                          LoadEstadoRest(
                                              nowActive: nowActive,
                                              user: widget.user));
                                      setState(() {
                                        nowActive = !nowActive;
                                        currentFiler = 0;
                                      });
                                    }
                                  },
                                  child: ReservarItem(
                                      title: "Ahora", isWhite: !nowActive))),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              height: 120,
                              child: InkWell(
                                onTap: () {
                                  if (nowActive) {
                                    BlocProvider.of<HomeBloc>(context).add(
                                        LoadEstadoRest(
                                            nowActive: nowActive,
                                            user: widget.user));
                                    setState(() {
                                      nowActive = !nowActive;
                                      currentFiler = 0;
                                    });
                                  }
                                },
                                child: ReservarItem(
                                    title: "Cualquier\nmomento",
                                    isWhite: nowActive),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    load
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: widhth,
                            child: Text(
                              "¿Qué estás buscando?",
                              style: TextStyle(
                                  color: textDrkgray,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                    load
                        ? Container()
                        : const SizedBox(
                            height: 10,
                          ),
                    load
                        ? Container()
                        : SizedBox(
                            width: widhth,
                            child: SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    widget.categories.length, (ii) {
                                  // var selectId = widget.categories[0].id;
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                    ),
                                    child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        onTap: () {
                                          setState(() {
                                            currentFiler = ii;
                                          });
                                          if (ii == 1 &&
                                              widget.offers.isNotEmpty) {
                                            setState(() {
                                              myRest = widget.restaurant;
                                            });
                                            // BlocProvider.of<HomeBloc>(context)
                                            //     .add(GetRestbyCategory(
                                            //         nowActive: nowActive,
                                            //         catId: widget
                                            //             .categories[ii].id,
                                            //         user: widget.user));

                                          } else if (ii == 0 &&
                                              widget.offers.isNotEmpty) {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(GetOffers(
                                                    user: widget.user));
                                          } else {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(GetRestbyCategory(
                                                    nowActive: nowActive,
                                                    catId: widget
                                                        .categories[ii].id,
                                                    user: widget.user));
                                            setState(() {
                                              myRest = widget.restaurantCat;
                                            });
                                          }
                                        },
                                        child: FilterChipItem(
                                          cheapItem: CheapItem(
                                            text: widget.categories[ii].name,
                                            icon: widget.categories[ii].image,
                                            seleted: currentFiler == ii,
                                          ),
                                          func: () {},
                                        )),
                                  );
                                }),
                              ),
                            ),
                          ),
                    load
                        ? Container()
                        : const SizedBox(
                            height: 20,
                          ),
                    // currentFiler == 0 ?
                    load
                        ? const LoadWidget()
                        : BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state is HomeCategoryLoading) {
                                return const Center(child: LoadWidget());
                              } else {
                                if (currentFiler == 1 &&
                                    widget.offers.isNotEmpty) {
                                  return RestaurantesWidget(
                                      restaurantes: widget.restaurant);
                                } else if (currentFiler == 0 &&
                                    widget.offers.isEmpty) {
                                  return RestaurantesWidget(
                                      restaurantes: widget.restaurant);
                                } else if (currentFiler == 0 &&
                                    widget.offers.isNotEmpty) {
                                  if (widget.offers.isNotEmpty) {
                                    return Offers(
                                        offers: widget.offers, user: user);
                                  } else {
                                    return const ErrorBlocWidget(
                                        errorText:
                                            '¡Parece que aún no hay ofertas!');
                                    /* return Container(
                                        height: 200,
                                        width: double.infinity,
                                        child: NotDataYet(
                                            message: "Aún no hay ofertas",
                                            retryAction: () {
                                              BlocProvider.of<HomeBloc>(context)
                                                  .add(LoadData(user: user));
                                            })); */
                                  }
                                } else {
                                  return RestaurantesWidget(
                                      restaurantes: widget.restaurantCat);
                                }
                              }
                            },
                          ),
                    // : Column(
                    //     children: [
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 20),
                    //         child: Row(
                    //           children: [
                    //             Text(
                    //               "Restaurantes",
                    //               style: TextStyle(
                    //                   color: textDrkgray,
                    //                   fontSize: 22,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //             const SizedBox(
                    //               width: 10,
                    //             ),
                    //             Text(
                    //               "para ti",
                    //               style: TextStyle(
                    //                   color: textDrkgray,
                    //                   fontSize: 13,
                    //                   fontWeight: FontWeight.w500),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       const Restaurantes(
                    //         type: "all",
                    //       )
                    //     ],
                    //   ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ]));
      },
    );
  }
}

class AddressSearch extends SearchDelegate<Suggestion> {
  // final sessionToken;

  // PlaceApiProvider apiClient;

  // var sessionToken = '123456';
  PlaceApiProvider apiClient = PlaceApiProvider('1234');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Suggestion('', ''));
      },
    );
  }

  @override
  String get searchFieldLabel => 'Escribe tu dirección...';

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, AsyncSnapshot snapshot) => query == ''
          ? Container(
              // padding: EdgeInsets.all(16.0),
              // child: Text('Enter your address'),
              )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data![index] as Suggestion).description),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data!.length,
                )
              : Container(),
    );
  }
}
