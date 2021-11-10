import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/screens/verificar_reserv_screen.dart';
import 'package:bookify/presentation/widgets/filter_chip.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';

class OwnedRestaurantDetails extends StatefulWidget {
  const OwnedRestaurantDetails({Key? key, required this.restaurante})
      : super(key: key);
  final RestaurantModel restaurante;

  @override
  State<OwnedRestaurantDetails> createState() => _OwnedRestaurantDetailsState();
}

class _OwnedRestaurantDetailsState extends State<OwnedRestaurantDetails> {
  TextEditingController nombres = TextEditingController();
  TextEditingController primer_apellido = TextEditingController();
  TextEditingController segundo_apellido = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController ubicacion = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateUser(user, password) async {}

  var _image;
  String base64Image = "";
  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      base64Image = base64Encode(_image.readAsBytesSync());
      print(base64Image);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              iconTheme: IconThemeData(
                color: splash_background,
              ),
              collapsedHeight: isTab() ? height / 5 : height / 4,
              backgroundColor: Colors.white,
              pinned: true,
              title: Text(
                "Azurmendi",
                style: TextStyle(
                    fontSize: 23,
                    color: textDrkgray,
                    fontWeight: FontWeight.w700),
              ),
              flexibleSpace: Container(
                width: widhth,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/halfPattern.png",
                        ))),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: getImage,
                        child: Hero(
                          tag: "profile_picture",
                          child: Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.only(top: 0, bottom: 5),
                            decoration: new BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 3, color: Colors.white),
                              image: DecorationImage(
                                image: _image == null
                                    ? AssetImage("assets/images/resutrant_logo1.png")
                                    : FileImage(_image)
                                        as ImageProvider, // <-- BACKGROUND IMAGE
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text("Toca para cambiar la foto",
                          style: TextStyle(
                              fontSize: 16,
                              color: textDrkgray,
                              fontWeight: FontWeight.w100)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: isTab() ? widhth / 5 : 30, vertical: 20),
              constraints: BoxConstraints(
                maxWidth: isLandccape ? widhth / 2 : widhth,
                minWidth: widhth,
              ),
              decoration: const BoxDecoration(),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: Text(
                            "Toca aquí para cambiar la foto de portada",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("Nombre del restaurante",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Nombre del restaurante",
                        prefixIcon:
                            Icon(Icons.store_rounded, color: Colors.orange),
                      ),
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("Descripción",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Descripción",
                        prefixIcon: Icon(Icons.text_rotation_none_sharp,
                            color: Colors.orange),
                      ),
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("Teléfono",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Teléfono",
                        prefixIcon: Icon(Icons.phone, color: Colors.orange),
                      ),
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("Ubicación",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Ubicación",
                        prefixIcon:
                            Icon(Icons.map_outlined, color: Colors.orange),
                      ),
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("Código postal",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Código postal",
                        prefixIcon:
                            Icon(Icons.near_me_outlined, color: Colors.orange),
                      ),
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("Ciudad",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Ciudad",
                        prefixIcon:
                            Icon(Icons.location_city, color: Colors.orange),
                      ),
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("Provincia",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Provincia",
                        prefixIcon:
                            Icon(Icons.location_city, color: Colors.orange),
                      ),
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("País",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "País",
                        prefixIcon: Icon(Icons.flag, color: Colors.orange),
                      ),
                    ),
                    TextField(
                      //controller: nombres,
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
                        label: Text("Web",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Web",
                        prefixIcon: Icon(Icons.web, color: Colors.orange),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        child: LargeButton(
                            text: "Guardar",
                            isWhite: false,
                            onTap: () {
                              // if ()
                              // Navigator.of(context).pop();
                            })),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
