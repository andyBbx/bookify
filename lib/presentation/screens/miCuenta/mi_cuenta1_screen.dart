import 'dart:convert';
import 'dart:io';
import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../confirmando_screen.dart';

class MiCuenta1Screen extends StatefulWidget {
  const MiCuenta1Screen({Key? key}) : super(key: key);

  @override
  State<MiCuenta1Screen> createState() => _MiCuenta1ScreenState();
}

class _MiCuenta1ScreenState extends State<MiCuenta1Screen> {
  TextEditingController nombres = TextEditingController();
  TextEditingController primer_apellido = TextEditingController();
  TextEditingController segundo_apellido = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController ubicacion = TextEditingController();

  User user = User();
  @override
  void initState() {
    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));
        if ((user.id)!.isEmpty) {
          //logout;
        } else {
          nombres.text = user.firstname.toString();
          primer_apellido.text = user.middlename.toString();
          segundo_apellido.text = user.lastname.toString();
          telefono.text = user.phone.toString();
          correo.text = user.email.toString();
          ubicacion.text = "Calle Don José 3";
        }
      }
    });
    super.initState();
  }

Future<void> updateUser(user, password) async {
    var data = {"email": user, "password": password};
    await postService(
            data, '/user/login')
        .then((value) {
      if (value['code'] != 200) {
        print("Situation");
        var error = jsonDecode(value['message']);
        throw Exception(error['message']);
      } else {
        saveUserModel(value['model']);
      }
    });
  }
  

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
                "Mi cuenta",
                style: TextStyle(
                    fontSize: 26,
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
                            margin: EdgeInsets.only(top: 0, bottom: 10),
                            decoration: new BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 3, color: Colors.white),
                              image: DecorationImage(
                                image: _image == null
                                    ? AssetImage("assets/images/user.png")
                                    : FileImage(_image) as ImageProvider, // <-- BACKGROUND IMAGE
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text("Toca para cambiar tu foto",
                          style: TextStyle(
                              fontSize: 16,
                              color: textDrkgray,
                              fontWeight: FontWeight.w100)),
                              SizedBox(height: 10,),
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
                    TextField(
                      controller: nombres,
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
                        label: Text("Nombre(s)",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Nombre(s)",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    TextField(
                      controller: primer_apellido,
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
                        label: Text("Primer apellido",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        hintText: "Primer apellido",
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    TextField(
                      controller: segundo_apellido,
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
                        hintText: "Segundo apellido",
                        label: Text("Segundo apellido",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    TextField(
                      controller: telefono,
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
                        hintText: "Teléfono",
                        label: Text("Teléfono",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/phone.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    TextField(
                      controller: correo,
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
                        hintText: "Correo",
                        label: Text("Correo",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 11, color: textDrkgray)),
                        prefixIcon: SvgPicture.asset(
                          "assets/images/icons/mail.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        child: LargeButton(
                            text: "Guardar cambios",
                            isWhite: false,
                            onTap: () {
                              // if ()
                              // Navigator.of(context).pop();
                            })),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        child: LargeButton(
                            text: "Cambiar contraseña",
                            isWhite: false,
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         const ConfirmandoScreen()));
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
