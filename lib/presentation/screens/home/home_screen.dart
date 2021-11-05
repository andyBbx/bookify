import 'dart:convert';

import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/home/tabs/favorites_tab.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/error_widget.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../mis_reservas_screen.dart';
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

  dynamic cat;

  dynamic reservation;

  @override
  void initState() {
    // TODO: implement initState
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
          ? LoadWidget()
          : BlocProvider(
              create: (context) => HomeBloc(context)..add(LoadData(user: user)),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadInit) {
                    rest = state.rest;
                    cat = state.categories;
                    restFav = state.restFav;
                    reservation = state.reservations;

                    return TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        HomeTab(
                          user: user,
                          categories: cat,
                          restaurant: rest,
                        ),
                        MisReservasScreen(reservations: reservation),
                        FavTab(
                          favRestaurant: restFav,
                        ),
                        ProfileTab(
                          user: user,
                        ),
                      ],
                    );
                  }
                  if (state is HomeLoadRest) {
                    rest = state.rest;

                    return TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        HomeTab(
                          user: user,
                          categories: cat,
                          restaurant: rest,
                        ),
                        MisReservasScreen(reservations: reservation),
                        FavTab(
                          favRestaurant: restFav,
                        ),
                        ProfileTab(
                          user: user,
                        ),
                      ],
                    );
                  } else if (state is HomeLoadFavorites) {
                    restFav = state.restFav;
                    return TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        HomeTab(
                          user: user,
                          categories: cat,
                          restaurant: rest,
                        ),
                        MisReservasScreen(reservations: reservation),
                        FavTab(
                          favRestaurant: restFav,
                        ),
                        ProfileTab(
                          user: user,
                        ),
                      ],
                    );
                  } else if (state is HomeLoading) {
                    return const Center(child: LoadWidget());
                  } else if (state is HomeFail) {
                    return Center(
                        child: ErrorBlocWidget(errorText: state.message));
                  }
                  return const Center(child: LoadWidget());
                },
              ),
            ),
    );
  }
}
