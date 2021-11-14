import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/logics/cubit/signup_cubit.dart';
import 'package:bookify/presentation/screens/home/tabs/pagger/resuturants.dart';
import 'package:bookify/presentation/widgets/filter_chip.dart';
import 'package:bookify/presentation/widgets/reservar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeTab extends StatefulWidget {
  final User user;
  const HomeTab({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentFiler = 0;

  List<CheapItem> cheapitems = [
    CheapItem(
      text: "De Todo",
      icon: "assets/images/icons/sushi.svg",
      seleted: true,
    ),
  ];

  void populateDat() {
    cheapitems.clear();
    cheapitems.addAll([
      CheapItem(
        text: "De Todo",
        icon: "",
        seleted: currentFiler == 0,
      ),
      CheapItem(
        text: "Sushi",
        icon: "assets/images/icons/sushi.svg",
        seleted: currentFiler == 1,
      ),
      CheapItem(
        text: "Pizza",
        icon: "assets/images/icons/pizza.svg",
        seleted: currentFiler == 2,
      ),
      CheapItem(
        text: "Hamburguesa",
        icon: "assets/images/icons/one-hamburguer.svg",
        seleted: currentFiler == 3,
      ),
    ]);
  }

  bool nowActive = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // populateDat();
  }

  @override
  Widget build(BuildContext context) {
    populateDat();

    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
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
                      direction: isTab() ? Axis.horizontal : Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Text(
                                  // "Hola, ${state}",
                                  'Hola, ' + widget.user.firstname.toString(),
                                  style: TextStyle(
                                      fontSize: 29,
                                      fontWeight: FontWeight.bold,
                                      color: textDrkgray),
                                );
                              },
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/icons/location.svg",
                                  fit: BoxFit.scaleDown,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Av. de Barcelona 3",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: textDrkgray)),
                                const SizedBox(
                                  width: 20,
                                ),
                                SvgPicture.asset(
                                  "assets/arrow_down.svg",
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                          width: widhth / 3,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
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
                                setState(() {
                                  nowActive = !nowActive;
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
                              setState(() {
                                nowActive = !nowActive;
                              });
                            }
                          },
                          child: ReservarItem(
                              title: "Cualquier\nmomento", isWhite: nowActive),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widhth,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(cheapitems.length, (ii) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentFiler = ii;
                          });
                        },
                        child: FilterChipItem(
                          cheapItem: cheapitems[ii],
                          func: () {},
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Restaurantes(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
