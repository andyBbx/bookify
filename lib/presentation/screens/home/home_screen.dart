import 'dart:convert';

import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/home/tabs/favorites_tab.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/error_widget.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'tabs/mis_reservas_screen.dart';
import 'tabs/profile_tab.dart';
import 'tabs/home_tab/view/tab_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  User user = User();
  late TabController _tabController;
  int seletcedTab = 0;

  dynamic rest;

  dynamic restFav;

  dynamic restCat;

  dynamic cat;

  dynamic reservation;

  bool loadScreen = false;

  @override
  void initState() {
    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        setState(() {
          user = user.fromJson(jsonDecode(userModelString!));
        });
        if ((user.id)!.isEmpty) {
          //logout;
        }
      }
    });
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: seletcedTab,
    );

    _tabController.addListener(() {
      setState(() {
        seletcedTab = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context)..add(LoadData(user: user)),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadInit) {
            rest = state.rest;
            cat = state.categories;
            restFav = state.restFav;
            reservation = state.reservations;
            loadScreen = false;
          } else if (state is HomeLoadRest) {
            restCat = state.rest;
            loadScreen = false;
          } else if (state is HomeLoadFavorites) {
            List<RestaurantModel> myRestFav = [];
            rest = state.rest;

            for (var i = 0; i < rest.length; i++) {
              if (rest[i].favorite == 1) {
                myRestFav.add(rest[i]);
              }
            }

            restFav = myRestFav;

            loadScreen = false;
          } else if (state is HomeLoadReservation) {
            reservation = state.reservations;
            loadScreen = false;
          } else if (state is HomeEditResLoad) {
            reservation = state.resv;
            rest = state.rest;
          }

          if (state is HomeLoading || state is HomeInitial) {
            return Center(child: bodyHome(true));
          } else if (state is HomeFail) {
            return Center(child: ErrorBlocWidget(errorText: state.message));
          } else if (state is HomeLoadInit) {
            return Center(child: bodyHome(false));
          } else {
            return Center(child: bodyHome(loadScreen));
          }
        },
      ),
    );
  }

  Widget bodyHome(bool load) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: backgroundColor,
            bottomNavigationBar: TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: "Inicio",
                  icon: SvgPicture.asset("assets/images/icons/home.svg",
                      color: seletcedTab == 0 ? textBold : tabunsellected),
                ),
                Tab(
                  text: "Reservas",
                  icon: SvgPicture.asset("assets/images/icons/calender.svg",
                      color: seletcedTab == 1 ? textBold : tabunsellected),
                ),
                Tab(
                  text: "Favoritos",
                  icon: SvgPicture.asset("assets/images/icons/heart.svg",
                      color: seletcedTab == 2 ? textBold : tabunsellected),
                ),
                Tab(
                  text: "Mi cuenta",
                  icon: SvgPicture.asset("assets/images/icons/profile.svg",
                      color: seletcedTab == 3 ? textBold : tabunsellected),
                ),
              ],
            ),
            body: user.auth_key!.isEmpty
                ? const LoadWidget()
                : load
                    ? const Center(
                        child: LoadWidget(),
                      )
                    : TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          RefreshIndicator(
                            onRefresh: () async =>
                                BlocProvider.of<HomeBloc>(context)
                                    .add(LoadData(user: user)),
                            child: HomeTab(
                              user: user,
                              categories: cat,
                              restaurant: rest,
                              restaurantCat: restCat,
                            ),
                          ),
                          RefreshIndicator(
                              onRefresh: () => _pullRefresh(),
                              child:
                                  MisReservasScreen(reservations: reservation)),
                          FavTab(
                            favRestaurant: restFav,
                          ),
                          ProfileTab(
                            user: user,
                            reservations: reservation,
                          ),
                        ],
                      ));
      },
    );
  }

  Future<void> _pullRefresh() async {
    BlocProvider.of<HomeBloc>(context).add(LoadData(user: user));
  }
}
