import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/owned_restaurant.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/bloc/owned_restaurants_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../../../data/service/place_service.dart';

class OwnedRestaurantDetails extends StatefulWidget {
  const OwnedRestaurantDetails({Key? key, required this.restaurante})
      : super(key: key);
  final OwnedRestaurantModel restaurante;

  @override
  State<OwnedRestaurantDetails> createState() => _OwnedRestaurantDetailsState();
}

class _OwnedRestaurantDetailsState extends State<OwnedRestaurantDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController municipality = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController web = TextEditingController();
  String menuUrl = "";

  bool updateDone = false;
  bool isNewRestaurant = false;

  @override
  void initState() {
    if (widget.restaurante.id != "") {
      name = TextEditingController(text: widget.restaurante.name);
      description = TextEditingController(text: widget.restaurante.description);
      phone = TextEditingController(text: widget.restaurante.phone);
      address = TextEditingController(text: widget.restaurante.address);
      postalCode = TextEditingController(text: widget.restaurante.postalCode);
      municipality =
          TextEditingController(text: widget.restaurante.municipality);
      province = TextEditingController(text: widget.restaurante.province);
      country = TextEditingController(text: widget.restaurante.country);
      web = TextEditingController(text: widget.restaurante.web);
      menuUrl = widget.restaurante.menuUrl;
    } else {
      name = TextEditingController(text: "Test");
      description = TextEditingController(text: "Test");
      phone = TextEditingController(text: "Test");
      address = TextEditingController(text: "Test");
      postalCode = TextEditingController(text: "Test");
      municipality = TextEditingController(text: "Test");
      province = TextEditingController(text: "Test");
      country = TextEditingController(text: "Test");
      web = TextEditingController(text: "Test");

      widget.restaurante.name = name.text.toString();
      widget.restaurante.description = description.text.toString();
      widget.restaurante.phone = phone.text.toString();
      widget.restaurante.address = address.text.toString();
      widget.restaurante.postalCode = postalCode.text.toString();
      widget.restaurante.municipality = municipality.text.toString();
      widget.restaurante.province = province.text.toString();
      widget.restaurante.country = country.text.toString();
      widget.restaurante.web = web.text.toString();
    }

    if (widget.restaurante.id == "") {
      setState(() {
        isNewRestaurant = true;
      });
    }
    super.initState();
  }

  Future<void> updateUser(user, password) async {}

  updateRestaurants() {
    BlocProvider.of<OwnedRestaurantsBloc>(context).add(LoadOwnedRestaurants());
  }

  var _image;
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

  bool pdfMenuSelected = false;
  String menuFileName = "";
  String base64File = "";

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      final fileBytes = File(file.path.toString()).readAsBytesSync();
      String mimeType = lookupMimeType(file.path.toString())!;
      base64File = 'data:$mimeType;base64,' + base64Encode(fileBytes);

      /* log(base64File); */

      setState(() {
        menuFileName = file.name;
      });
    } else {
      /* log("User cancelled file picking"); */
    }
  }

  @override
  Widget build(BuildContext context) {
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandccape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return BlocBuilder<OwnedRestaurantsBloc, OwnedRestaurantsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                  iconTheme: IconThemeData(
                    color: splash_background,
                  ),
                  collapsedHeight: 210,
                  backgroundColor: Colors.white,
                  pinned: true,
                  title: Text(
                    widget.restaurante.name,
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
                                margin:
                                    const EdgeInsets.only(top: 0, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 3, color: Colors.white),
                                  image: DecorationImage(
                                    image: _image == null
                                        ? (widget.restaurante.logo).isNotEmpty
                                            ? NetworkImage(
                                                widget.restaurante.logo)
                                            : const AssetImage(
                                                    "assets/halfPattern.png")
                                                as ImageProvider
                                        : FileImage(
                                            _image), // <-- BACKGROUND IMAGE
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
                        /* Column(
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
                        ), */
                        TextField(
                          controller: name,
                          onChanged: (value) {
                            setState(() {
                              widget.restaurante.name = value;
                            });
                          },
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
                                style: TextStyle(
                                    fontSize: 11, color: textDrkgray)),
                            hintText: "Nombre del restaurante",
                            prefixIcon: const Icon(Icons.store_rounded,
                                color: Colors.orange),
                          ),
                        ),
                        TextField(
                          controller: description,
                          onChanged: (value) {
                            setState(() {
                              widget.restaurante.description = value;
                            });
                          },
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
                                style: TextStyle(
                                    fontSize: 11, color: textDrkgray)),
                            hintText: "Descripción",
                            prefixIcon: const Icon(
                                Icons.text_rotation_none_sharp,
                                color: Colors.orange),
                          ),
                        ),
                        TextField(
                          controller: phone,
                          onChanged: (value) {
                            setState(() {
                              widget.restaurante.phone = value;
                            });
                          },
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
                                style: TextStyle(
                                    fontSize: 11, color: textDrkgray)),
                            hintText: "Teléfono",
                            prefixIcon:
                                const Icon(Icons.phone, color: Colors.orange),
                          ),
                        ),
                        TextField(
                          readOnly: true,
                          maxLines: 2,
                          onTap: () async {
                            final Suggestion? result = await showSearch(
                              context: context,
                              delegate: AddressSearch(),
                            );

                            if (result != null) {
                              final placeDetails =
                                  await PlaceApiProvider('12345')
                                      .getPlaceDetailFromId(result.placeId);
                              setState(() {
                                widget.restaurante.address = result.description;
                                address.text = widget.restaurante.address;
                                widget.restaurante.postalCode =
                                    placeDetails.zipCode != null
                                        ? placeDetails.zipCode!
                                        : "";
                                widget.restaurante.municipality =
                                    placeDetails.city!;
                                widget.restaurante.province =
                                    placeDetails.province!;
                                widget.restaurante.country =
                                    placeDetails.country!;
                                widget.restaurante.latitude =
                                    placeDetails.lat!.toString();
                                widget.restaurante.longitude =
                                    placeDetails.long!.toString();
                              });
                            }
                          },
                          controller: address,
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
                                style: TextStyle(
                                    fontSize: 11, color: textDrkgray)),
                            hintText: "Ubicación",
                            prefixIcon: const Icon(Icons.map_outlined,
                                color: Colors.orange),
                          ),
                        ),
                        // TextField(
                        //   controller: postalCode,
                        //   readOnly: true,
                        //   // onChanged: (value) {
                        //   //   setState(() {
                        //   //     widget.restaurante.postalCode = value;
                        //   //   });
                        //   // },
                        //   decoration: InputDecoration(
                        //     enabledBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     focusedBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     fillColor: Colors.red,
                        //     label: Text("Código postal",
                        //         textAlign: TextAlign.start,
                        //         style: TextStyle(
                        //             fontSize: 11, color: textDrkgray)),
                        //     hintText: "Código postal",
                        //     prefixIcon: const Icon(Icons.near_me_outlined,
                        //         color: Colors.orange),
                        //   ),
                        // ),
                        // TextField(
                        //   controller: municipality,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       widget.restaurante.municipality = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //     enabledBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     focusedBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     fillColor: Colors.red,
                        //     label: Text("Ciudad",
                        //         textAlign: TextAlign.start,
                        //         style: TextStyle(
                        //             fontSize: 11, color: textDrkgray)),
                        //     hintText: "Ciudad",
                        //     prefixIcon: const Icon(Icons.location_city,
                        //         color: Colors.orange),
                        //   ),
                        // ),
                        // TextField(
                        //   controller: province,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       widget.restaurante.province = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //     enabledBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     focusedBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     fillColor: Colors.red,
                        //     label: Text("Provincia",
                        //         textAlign: TextAlign.start,
                        //         style: TextStyle(
                        //             fontSize: 11, color: textDrkgray)),
                        //     hintText: "Provincia",
                        //     prefixIcon: const Icon(Icons.location_city,
                        //         color: Colors.orange),
                        //   ),
                        // ),
                        // TextField(
                        //   controller: country,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       widget.restaurante.country = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //     enabledBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     focusedBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: splash_background),
                        //     ),
                        //     fillColor: Colors.red,
                        //     label: Text("País",
                        //         textAlign: TextAlign.start,
                        //         style: TextStyle(
                        //             fontSize: 11, color: textDrkgray)),
                        //     hintText: "País",
                        //     prefixIcon:
                        //         const Icon(Icons.flag, color: Colors.orange),
                        //   ),
                        // ),
                        TextField(
                          controller: web,
                          keyboardType: TextInputType.url,
                          inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                          onChanged: (value) {
                            setState(() {
                              widget.restaurante.web = value;
                            });
                          },
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
                                style: TextStyle(
                                    fontSize: 11, color: textDrkgray)),
                            hintText: "https://tusitioweb.es",
                            prefixIcon:
                                const Icon(Icons.web, color: Colors.orange),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        menuUrl.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  launchURL(menuUrl);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: const Text(
                                    "Ver menú actual",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5)),
                          child: InkWell(
                            onTap: getFile,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Toca aquí para añadir ó editar tu Menú (PDF, JPG o PNG)",
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        menuFileName.isNotEmpty
                            ? Text(
                                menuFileName,
                                style: TextStyle(color: Colors.grey),
                              )
                            : SizedBox(),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<OwnedRestaurantsBloc,
                            OwnedRestaurantsState>(builder: (context, state) {
                          if (state is UpdatingOwnedRestaurant ||
                              (state is CreatingRestaurant)) {
                            return const SizedBox(
                              width: 100,
                              height: 100,
                              child: LoadWidget(),
                            );
                          } else if ((state is ReadyUpdatingOwnedRestaurant) ||
                              (state is DoneCreatingRestaurant)) {
                            BlocProvider.of<OwnedRestaurantsBloc>(context)
                                .add(LoadOwnedRestaurants());

                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
                            return const SizedBox();
                          } else {
                            return SizedBox(
                                child: LargeButton(
                                    text: "Guardar",
                                    isWhite: false,
                                    onTap: () {
                                      if (isNewRestaurant) {
                                        BlocProvider.of<OwnedRestaurantsBloc>(
                                                context)
                                            .add(CreateRestaurant(
                                                restaurantModel:
                                                    widget.restaurante,
                                                base64Logo: base64Image,
                                                base64MenuFile: base64File));
                                      } else {
                                        BlocProvider.of<OwnedRestaurantsBloc>(
                                                context)
                                            .add(UpdateOwnedRestaurant(
                                                restaurantModel:
                                                    widget.restaurante,
                                                base64Logo: base64Image,
                                                base64MenuFile: base64File));
                                      }
                                    }));
                          }
                        }),
                        /* renderInfoMessage(), */
                        const SafeArea(child: SizedBox()),
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
