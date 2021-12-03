import 'dart:convert';
import 'dart:io';
import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/data/service/service.dart';
import 'package:bookify/presentation/screens/home/bloc/home_bloc.dart';
import 'package:bookify/presentation/screens/pre_login_screen.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

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

  final _formKeyAccount = GlobalKey<FormState>();

  bool onError = false;

  User user = User();
  bool loadPassword = false;
  bool load = true;
  @override
  void initState() {
    Utils().startSharedPreferences().then((prefs) {
      String? userModelString = prefs.getString("user");
      if (Utils().checkJsonArray(userModelString)) {
        user = user.fromJson(jsonDecode(userModelString!));
        load = false;
        setState(() {});
        if ((user.id)!.isEmpty) {
          //logout;
        } else {
          nombres.text = user.firstname.toString();
          primer_apellido.text = user.middlename.toString();
          segundo_apellido.text = user.lastname.toString();
          telefono.text = user.phone.toString();
          correo.text = user.email.toString();
          profileImage = user.avatar;
          // ubicacion.text = "Calle Don José 3";
        }
      }
    });
    super.initState();
  }

  Future<void> updateUser(user, password) async {
    var data = {"email": user, "password": password};
    await postService(data, '/user/login', '').then((value) {
      if (value['code'] != 200) {
        var error = jsonDecode(value['message']);
        throw Exception(error['message']);
      } else {
        saveUserModel(value['model']);
      }
    });
  }

  var _image;
  String? profileImage = "";
  String base64Image = "";
  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    var pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 80);
    /*  print(pickedFile.mimeType); */

    setState(() {
      _image = File(pickedFile!.path);
      String mimeType = lookupMimeType(_image.path)!;
      base64Image =
          'data:$mimeType;base64,' + base64Encode(_image.readAsBytesSync());
      //print(base64Image);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    Widget BotonGuardar = SizedBox(
        child: LargeButton(
            text: "Guardar cambios",
            isWhite: false,
            onTap: () {
              if (_formKeyAccount.currentState!.validate()) {
                user.firstname = nombres.text;
                user.middlename = primer_apellido.text;
                user.lastname = segundo_apellido.text;
                user.phone = telefono.text;
                user.email = correo.text;
                user.avatar = base64Image;

                BlocProvider.of<HomeBloc>(context).add(EditCuenta(user: user));
              }
              // if ()
              // Navigator.of(context).pop();
            }));

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is EditUserFail) {
          BotonGuardar = Column(
            children: [
              const Text('Ha ocurrido un error'),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  child: LargeButton(
                      text: "Guardar cambios",
                      isWhite: false,
                      onTap: () {
                        user.firstname = nombres.text;
                        user.middlename = primer_apellido.text;
                        user.lastname = segundo_apellido.text;
                        user.phone = telefono.text;
                        user.email = correo.text;
                        user.avatar = base64Image;

                        BlocProvider.of<HomeBloc>(context)
                            .add(EditCuenta(user: user));
                        // if ()
                        // Navigator.of(context).pop();
                      }))
            ],
          );
        } else if (state is EditUserLoading) {
          BotonGuardar = const CircularProgressIndicator();
        } else if (state is EditUserLoad) {
          BotonGuardar = Column(
            children: [
              const Text('Cambios guardados'),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  child: LargeButton(
                      text: "Guardar cambios",
                      isWhite: false,
                      onTap: () {
                        user.firstname = nombres.text;
                        user.middlename = primer_apellido.text;
                        user.lastname = segundo_apellido.text;
                        user.phone = telefono.text;
                        user.email = correo.text;
                        user.avatar = base64Image;

                        BlocProvider.of<HomeBloc>(context)
                            .add(EditCuenta(user: user));
                        // if ()
                        // Navigator.of(context).pop();
                      }))
            ],
          );
        }
        // else if (state is EditPasswordFail) {
        //   Navigator.pop(context);

        // }
        return Scaffold(
          backgroundColor: Colors.white,
          body: load
              ? const Center(child: LoadWidget())
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                        iconTheme: IconThemeData(
                          color: splash_background,
                        ),
                        collapsedHeight: 220,
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
                                      margin: const EdgeInsets.only(
                                          top: 0, bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 3, color: Colors.white),
                                          image: DecorationImage(
                                              onError: (value, v) {
                                                setState(() {
                                                  onError = true;
                                                });
                                              },
                                              fit: BoxFit.cover,
                                              image: onError ||
                                                      profileImage == null &&
                                                          _image == null
                                                  ? const AssetImage(
                                                      "assets/images/user.png")
                                                  : _image == null
                                                      ? NetworkImage(
                                                          profileImage!)
                                                      : FileImage(_image)
                                                          as ImageProvider)),
                                    ),
                                  ),
                                ),
                                Text("Toca para cambiar tu foto",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: textDrkgray,
                                        fontWeight: FontWeight.w100)),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: isTab() ? widhth / 5 : 30,
                            vertical: 20),
                        constraints: BoxConstraints(
                          maxWidth: isLandccape ? widhth / 2 : widhth,
                          minWidth: widhth,
                        ),
                        decoration: const BoxDecoration(),
                        child: Form(
                          key: _formKeyAccount,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                validator: (val) => val.toString().isNotEmpty
                                    ? null
                                    : "Este campo es requerido",
                                controller: nombres,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  fillColor: Colors.red,
                                  label: Text("Nombre(s)",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 11, color: textDrkgray)),
                                  hintText: "Nombre(s)",
                                  prefixIcon: SvgPicture.asset(
                                    "assets/images/icons/profile.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              TextFormField(
                                validator: (val) => val.toString().isNotEmpty
                                    ? null
                                    : "Este campo es requerido",
                                controller: primer_apellido,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  fillColor: Colors.red,
                                  label: Text("Primer apellido",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 11, color: textDrkgray)),
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
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  fillColor: Colors.red,
                                  hintText: "Segundo apellido",
                                  label: Text("Segundo apellido (opcional)",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 11, color: textDrkgray)),
                                  prefixIcon: SvgPicture.asset(
                                    "assets/images/icons/profile.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              TextFormField(
                                validator: (val) => val.toString().isNotEmpty
                                    ? null
                                    : "Este campo es requerido",
                                controller: telefono,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  fillColor: Colors.red,
                                  hintText: "Teléfono",
                                  label: Text("Teléfono",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 11, color: textDrkgray)),
                                  prefixIcon: SvgPicture.asset(
                                    "assets/images/icons/phone.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              TextFormField(
                                validator: (val) => val.toString().isNotEmpty
                                    ? null
                                    : "Este campo es requerido",
                                controller: correo,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: splash_background),
                                  ),
                                  fillColor: Colors.red,
                                  hintText: "Correo",
                                  label: Text("Correo",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 11, color: textDrkgray)),
                                  prefixIcon: SvgPicture.asset(
                                    "assets/images/icons/mail.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              BotonGuardar,
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  child: LargeButton(
                                      text: "Cambiar contraseña",
                                      isWhite: false,
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(EditPasswordInit());
                                        showDialog(
                                            context: context,
                                            builder: (_) => BlocProvider.value(
                                                value:
                                                    BlocProvider.of<HomeBloc>(
                                                        context),
                                                child: Dialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: isTab()
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4
                                                                : 30),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: passwordBox(user))));
                                      })),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Utils()
                                      .startSharedPreferences()
                                      .then((prefs) {
                                    prefs.clear();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PreLoginScreen()));
                                  });
                                },
                                child: Text("Cerrar sesión",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black87)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }

  passwordBox(userModdel) {
    TextEditingController password = TextEditingController();
    TextEditingController newPassword = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    bool load = false;
    String errorStr = "Algo salio mal";
    bool error = false;

    bool passwordOk = false;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is EditPasswordFail) {
          load = false;
          error = true;
          errorStr = state.message;
        } else if (state is EditPasswordInit) {
          load = false;
          passwordOk = false;
          error = false;
        } else if (state is EditPasswordLoading) {
          error = false;
          load = true;
        } else if (state is EditPasswordLoad) {
          passwordOk = true;
          // Navigator.pop(context);
        }
        return Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: 20),
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Form(
                key: _formKey,
                child: passwordOk
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 50,
                            color: Colors.green[700],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Contraseña actualizada',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Cambiar contraseña',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          TextFormField(
                            controller: password,
                            onChanged: (val) {
                              user.password = val;
                            },
                            obscureText: true,
                            validator: (val) => val.toString().length >= 6
                                ? null
                                : "Este campo es requerido",
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: splash_background),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: splash_background),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: splash_background),
                              ),
                              label: const Text("Contraseña"),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xFFDB7714)),
                            ),
                          ),
                          TextFormField(
                            controller: newPassword,
                            onChanged: (val) {
                              user.password = val;
                            },
                            obscureText: true,
                            validator: (val) => val.toString().length >= 6
                                ? null
                                : "Este campo es requerido",
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: splash_background),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: splash_background),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: splash_background),
                              ),
                              label: const Text("Nueva contraseña"),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xFFDB7714)),
                            ),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          error
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.red[700],
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                        child: Text(errorStr,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis)),
                                  ],
                                )
                              : Container(),
                          Align(
                              alignment: Alignment.bottomRight,
                              // ignore: deprecated_member_use
                              child: load
                                  ? const CircularProgressIndicator()
                                  : InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          user.password = password.text;
                                          BlocProvider.of<HomeBloc>(context)
                                              .add(EditPassword(
                                                  user: user,
                                                  newPassword:
                                                      newPassword.text));
                                        }
                                      },
                                      child: const Text(
                                        'Confirmar',
                                        style: TextStyle(fontSize: 15),
                                      ))),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
