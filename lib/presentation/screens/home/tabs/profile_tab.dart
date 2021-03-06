import 'dart:convert';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/miCuenta/bloc/micuenta_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../miCuenta/mi_cuenta1_screen.dart';
import 'mis_reservas_screen.dart';
import '../../pre_login_screen.dart';

class ProfileTab extends StatefulWidget {
  final List<ReservationModel> reservations;
  const ProfileTab({Key? key, required this.reservations}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTab();
}

class _ProfileTab extends State<ProfileTab> {
  User user = User();
  bool onError = false;

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
  }

  @override
  Widget build(BuildContext context) {
    onError = false;
    double widht = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: isTab() ? height / 4 : height / 4,
            pinned: true,
            flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: widht,
                  child: SvgPicture.asset(
                    isLandccape
                        ? "prelogin_frame_landscape.svg"
                        : "assets/pre_login_frame.svg",
                    color: Colors.white.withAlpha(80),
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            // backgroundImage:
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                onError: (value, v) {
                                  setState(() {
                                    onError = true;
                                  });
                                },
                                fit: BoxFit.cover,
                                image: onError || user.avatar == null
                                    ? const AssetImage("assets/images/user.png")
                                    : NetworkImage(user.avatar!)
                                        as ImageProvider)),
                        width: isTab() ? 120 : 110.0,
                        height: isTab() ? 120 : 110.0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hola, ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isTab() ? 29 : 19,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            user.firstname.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isTab() ? 29 : 19,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: isTab() ? 2 : 1,
              childAspectRatio: isTab() ? 5 : 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MultiBlocProvider(providers: [
                                      BlocProvider(
                                        create: (context) => MicuentaBloc(),
                                      ),
                                      BlocProvider(
                                        create: (context) => HomeBloc(context),
                                      ),
                                    ], child: const MiCuenta1Screen()))).then(
                            (value) {
                          Utils().startSharedPreferences().then((prefs) {
                            String? userModelString = prefs.getString("user");
                            if (Utils().checkJsonArray(userModelString)) {
                              setState(() {
                                user =
                                    user.fromJson(jsonDecode(userModelString!));
                              });
                              if ((user.id)!.isEmpty) {
                                //logout;
                              }
                            }
                          });
                        });
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => MiCuenta1Screen()));
                      },
                      title: Text(
                        "Mi cuenta",
                        style: TextStyle(
                            color: textDrkgray,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/icons/profile.svg",
                        color: textBold,
                      ),
                    ),
                    Container(height: 1, color: devicerColor),
                  ],
                ),
                // Column(
                //   children: [
                //     ListTile(
                //       title: Text(
                //         "Tarjetas",
                //         style: TextStyle(
                //             color: textDrkgray,
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       leading: SvgPicture.asset(
                //         "assets/images/icons/card.svg",
                //         color: textBold,
                //       ),
                //     ),
                //     Container(height: 1, color: devicerColor),
                //   ],
                // ),
                Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => HomeBloc(context),
                                  child: MisReservasScreen(
                                    reservations: widget.reservations,
                                  ),
                                )));
                      },
                      title: Text(
                        "Reservas",
                        style: TextStyle(
                            color: textDrkgray,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/icons/calender.svg",
                        color: textBold,
                      ),
                    ),
                    Container(height: 1, color: devicerColor),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Ayuda",
                        style: TextStyle(
                            color: textDrkgray,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/icons/help.svg",
                        color: textBold,
                      ),
                    ),
                    Container(height: 1, color: devicerColor),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        "T??rminos y condiciones",
                        style: TextStyle(
                            color: textDrkgray,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/icons/file.svg",
                        color: textBold,
                      ),
                    ),
                    Container(height: 1, color: devicerColor),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Utils().startSharedPreferences().then((prefs) {
                          prefs.clear();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => PreLoginScreen()));
                        });
                      },
                      title: Text(
                        "Cerrar sesi??n",
                        style: TextStyle(
                            color: textDrkgray,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/icons/logout.svg",
                        color: textBold,
                      ),
                    ),
                    Container(height: 1, color: devicerColor),
                  ],
                ),
              ],
            ),
          )
        ],
      ),

      // Stack(
      //   children: [
      //     Positioned(
      //       top: 0,
      //       right: 0,
      //       left: 0,
      //       child:
      //     ),
      //     Positioned(
      //         top: height / 3,
      //         child: Container(
      //           padding: EdgeInsets.only(top: 0, left: 20, right: 20),
      //           constraints: BoxConstraints(
      //             maxWidth: isLandccape ? widht / 2 : widht,
      //             minWidth: widht,
      //           ),
      //           height: height,
      //           decoration: BoxDecoration(
      //             color: splash_Logo,
      //           ),
      //           child: SingleChildScrollView(

      //           ),
      //         )),
      //     Positioned(
      //       top: height / 10,
      //       right: 0,
      //       left: 0,
      // child:
      //     ),
      //   ],
      // ),
    );
  }
}
