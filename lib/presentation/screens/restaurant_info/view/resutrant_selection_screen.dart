import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/restaurant_info/bloc/restaurant_info_bloc.dart';

import 'package:bookify/presentation/screens/verificar_reserv_screen.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/filter_chip.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResturantSelectionScreen extends StatefulWidget {
  const ResturantSelectionScreen({Key? key, required this.restaurante})
      : super(key: key);
  final RestaurantModel restaurante;

  @override
  State<ResturantSelectionScreen> createState() =>
      _ResturantSelectionScreenState();
}

class _ResturantSelectionScreenState extends State<ResturantSelectionScreen> {
  int selextedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  double radius = 60;

  // final String dateReservation = DateTime.now().toString();
  var tempDate = Jiffy(DateTime.now()).dateTime;

  User user = User();

  bool onError = false;

// reservationData

  DateTime myDate = DateTime.now();
  int myQuantity = 3;
  DateTime myHour = DateTime.now();
  String myDataExtra = '';

  @override
  void initState() {
    super.initState();

    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));
      }
    });

    BlocProvider.of<RestaurantInfoInfoBloc>(context).add(LoadDate(
        selectDate: DateTime.now(), times: widget.restaurante.schedule));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 150) {
        setState(() {
          radius = 60;
        });
      } else if (_scrollController.position.pixels < 200) {
        setState(() {
          radius = 40;
        });
      } else if (_scrollController.position.pixels < 400) {
        setState(() {
          radius = 20;
        });
      }
    });
  }

  int count = 3;

  Widget hoursData = const Center(child: LoadWidget());

  bool hourData = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;

    return BlocBuilder<RestaurantInfoInfoBloc, RestaurantInfoState>(
      builder: (context, state) {
        if (state is RestaurantInfoHoursLoading) {
          hoursData = const Center(child: LoadWidget());
        } else if (state is RestaurantInfoHoursLoaded) {
          if (state.listHours.length > 0) {
            hourData = true;

            hoursData = GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: !isTab() ? 3 : 4,
                childAspectRatio: !isTab() ? 3 : 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(state.listHours.length, (index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                        color: selextedIndex == index ? textBold : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: textBold,
                        )),
                    child: InkWell(
                      onTap: () {
                        selextedIndex = index;
                        myHour = state.listHours[index];
                        setState(() {});
                      },
                      child: FilterChipHour(
                        cheapItem: CheapItem(
                            text: DateFormat('HH:mm')
                                .format(state.listHours[index]),
                            icon: "icon",
                            seleted: selextedIndex == index ? true : false),
                      ),
                    ),
                  );
                }));
          } else {
            hourData = false;
            hoursData = Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text('No hay horas disponibles'));
          }
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (widget.restaurante.favorite == 1) {
                        //
                        setState(() {
                          widget.restaurante.favorite = 0;
                        });
                        BlocProvider.of<HomeBloc>(context).add(RemoveFavorite(
                            restId: widget.restaurante.id!, user: user));
                      } else {
                        setState(() {
                          widget.restaurante.favorite = 1;
                        });
                        //
                        BlocProvider.of<HomeBloc>(context).add(AddFavorite(
                            restId: widget.restaurante.id!, user: user));
                      }
                    },
                    icon: Icon(
                      widget.restaurante.favorite == 1
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: widget.restaurante.favorite == 1
                          ? favrioteColor
                          : textDrkgray,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
                pinned: true,
                backgroundColor: Colors.white,
                expandedHeight: 320,
                collapsedHeight: 60,
                // toolBarColor: Colors.transparent,
                flexibleSpace: SizedBox(
                  width: widhth,
                  height: 350,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              Image.asset(
                            "assets/images/resturant2.jpeg",
                            fit: BoxFit.cover,
                          ),
                          options: CarouselOptions(
                            scrollPhysics: NeverScrollableScrollPhysics(),
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            // enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 1.4,
                            initialPage: 1,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          right: 0,
                          left: 0,
                          child: Container(
                            width: radius * 2,
                            height: radius * 2,
                            decoration: BoxDecoration(
                              image: widget.restaurante.logo == null
                                  ? null
                                  : DecorationImage(
                                      onError: (value, v) {
                                        setState(() {
                                          onError = true;
                                        });
                                      },
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          widget.restaurante.logo!)),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: !onError
                                ? Container()
                                : CircleAvatar(
                                    radius: radius,
                                    backgroundColor: Colors.white,
                                    child: logo(100)),
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
                    Text(
                      widget.restaurante.name!,
                      style: TextStyle(
                        fontSize: 25,
                        color: textDrkgray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RatingBarIndicator(
                      rating:
                          double.parse(widget.restaurante.rating.toString()),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: textBold,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.restaurante.description!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: textDrkgray.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/icons/location.svg",
                            fit: BoxFit.scaleDown,
                            width: 11,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(widget.restaurante.address!,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: textDrkgray,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.restaurante.latitude != null &&
                            widget.restaurante.longitude != null
                        ? GestureDetector(
                            onTap: () {
                              if (widget.restaurante.latitude != null &&
                                  widget.restaurante.longitude != null) {
                                launchURL(
                                    "https://www.google.com/maps/search/?api=1&query=${widget.restaurante.latitude},${widget.restaurante.longitude}");
                              }
                            },
                            child: Text(
                              "Ver dirección",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: textBold,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.restaurante.menu_url == null
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              launchURL(widget.restaurante.menu_url!);
                            },
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant,
                                  color: textBold,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Ver menú',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: textBold,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            )),
                          ),
                    widget.restaurante.menu_url == null
                        ? const SizedBox()
                        : const SizedBox(
                            height: 20,
                          ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.restaurante.web == null
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    launchURL(widget.restaurante.web!);
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset:
                                              Offset(2, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          "assets/images/icons/world.svg"),
                                    ),
                                  ),
                                ),
                          widget.restaurante.rss.length == 0
                              ? const SizedBox()
                              : Center(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.restaurante.rss.length >= 5
                                            ? 5
                                            : widget.restaurante.rss.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return widget.restaurante.rss[index]
                                                  ['value'] ==
                                              null
                                          ? const SizedBox()
                                          : Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: (() => launchURL(widget
                                                      .restaurante
                                                      .rss[index]['value'])),
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 4,
                                                          offset: Offset(2,
                                                              2), // Shadow position
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Image.network(
                                                        widget.restaurante
                                                            .rss[index]['image']
                                                            .toString(),
                                                        fit: BoxFit.contain,
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object
                                                                    exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return SvgPicture
                                                              .asset(
                                                            "assets/logo.svg",
                                                            fit: BoxFit.contain,
                                                            width: 35,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Reserva ahora",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          color: textDrkgray),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personas",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: textDrkgray),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 45,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.remove,
                                    color: textDrkgray.withOpacity(0.45),
                                  ),
                                  onTap: () {
                                    if (count >= 2) {
                                      count--;
                                      setState(() {
                                        myQuantity = count;
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 17,
                                ),
                                Text(
                                  count.toString(),
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: textDrkgray),
                                ),
                                const SizedBox(
                                  width: 17,
                                ),
                                InkWell(
                                  onTap: () {
                                    count++;
                                    setState(() {
                                      myQuantity = count;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: textDrkgray.withOpacity(0.45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      width: widhth,
                      color: devicerColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fecha",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: textDrkgray),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime.now()
                                      .add(const Duration(days: 14)),
                                  theme: DatePickerTheme(
                                      backgroundColor: Colors.white,
                                      itemStyle: TextStyle(color: textDrkgray),
                                      doneStyle: TextStyle(color: textBold)),
                                  onConfirm: (date) {
                                setState(() {
                                  myDate = date;
                                  tempDate = date;
                                });
                                BlocProvider.of<RestaurantInfoInfoBloc>(context)
                                    .add(LoadDate(
                                        selectDate: tempDate,
                                        times: widget.restaurante.schedule));
                              }, currentTime: tempDate, locale: LocaleType.en);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(2, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    Jiffy(tempDate).format("dd / MM / yy"),
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: textDrkgray),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      width: widhth,
                      color: devicerColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: widhth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Horario",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: textDrkgray),
                          ),
                          hoursData,
                          // Container(
                          //   width: widhth,
                          //   height: 100,
                          //   child: SingleChildScrollView(
                          //     child: Column(
                          //       children: List.generate(3, (index) {
                          //         return Container(
                          //             padding: EdgeInsets.symmetric(vertical: 5),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceEvenly,
                          //               children: [
                          //                 SizedBox(
                          //                   height: 40,
                          //                   child: FilterChipItem(
                          //                     cheapItem: CheapItem(
                          //                         text: times[index],
                          //                         icon: "icon",
                          //                         seleted: index == 0),
                          //                     func: () {
                          //                       selextedIndex = index;
                          //                     },
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 40,
                          //                   child: FilterChipItem(
                          //                     cheapItem: CheapItem(
                          //                         text: times[index + 1],
                          //                         icon: "icon",
                          //                         seleted: false),
                          //                     func: () {
                          //                       selextedIndex = index + 1;
                          //                     },
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 40,
                          //                   child: FilterChipItem(
                          //                     cheapItem: CheapItem(
                          //                         text: times[index + 2],
                          //                         icon: "icon",
                          //                         seleted: false),
                          //                     func: () {
                          //                       selextedIndex = index + 2;
                          //                     },
                          //                   ),
                          //                 ),
                          //               ],
                          //             ));
                          //       }),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      width: widhth,
                      color: devicerColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: widhth,
                      child: Text(
                        "Intolerancias ó alergias",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: textDrkgray),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: widhth,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              // textAlignVertical: TextAlignVertical.top,
                              textInputAction: TextInputAction.done,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                  alignLabelWithHint: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText: 'Escribe aqui...'
                                  // label: Text(
                                  //   'Escribe aqui...',
                                  // )
                                  ),
                              onSaved: (value) {
                                setState(() {
                                  myDataExtra = value!;
                                });
                              },
                            ),
                          ),
                        )),
                    !hourData
                        ? Container()
                        : const SizedBox(
                            height: 30,
                          ),
                    !hourData
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: widhth / 2.5,
                                  child: LargeButton(
                                      text: "Cancelar",
                                      isWhite: true,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      })),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                  width: widhth / 2.5,
                                  child: LargeButton(
                                      text: "Aceptar",
                                      isWhite: false,
                                      onTap: () {
                                        if (hourData) {
                                          _formKey.currentState!.save();

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  RestaurantInfoInfoBloc(
                                                                      context),
                                                            ),
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  HomeBloc(
                                                                      context),
                                                            ),
                                                          ],
                                                          child:
                                                              VerificarReservaScreen(
                                                            reservationModel: ReservationModel(
                                                                id: '',
                                                                clientId:
                                                                    user.id!,
                                                                restaurantData:
                                                                    widget
                                                                        .restaurante,
                                                                time: myHour
                                                                    .toString(),
                                                                date: myDate,
                                                                observation:
                                                                    myDataExtra,
                                                                rated: '',
                                                                status: 0,
                                                                createdAt:
                                                                    DateTime
                                                                        .now(),
                                                                updatedAt:
                                                                    DateTime
                                                                        .now(),
                                                                quantity:
                                                                    myQuantity,
                                                                tables: []),
                                                          ))));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'No hay horarios disponibles para el día seleccionado')));
                                        }
                                      })),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
