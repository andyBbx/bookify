import 'dart:convert';

import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/tabs/favorites_tab.dart';
import 'package:flutter/material.dart';
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
            text: "Reservaciones",
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
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeTab(
            user: user,
          ),
          MisReservasScreen(),
          FavTab(),
          ProfileTab(
            user: user,
          ),
        ],
      ),
    );
  }
}
