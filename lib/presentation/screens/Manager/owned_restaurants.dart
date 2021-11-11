import 'package:bookify/constants/color.dart';
import 'package:bookify/constants/utils.dart';
import 'package:bookify/data/models/resturant.dart';
import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/table_item_card.dart';
import 'package:bookify/presentation/screens/Manager/owned_restaurant_details.dart';
import 'package:bookify/presentation/widgets/large_button.dart';
import 'package:bookify/presentation/widgets/resturants_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class MyOwnedRestaurants extends StatefulWidget {
  MyOwnedRestaurants({Key? key}) : super(key: key);

  @override
  _MyOwnedRestaurantsState createState() => _MyOwnedRestaurantsState();
}

class _MyOwnedRestaurantsState extends State<MyOwnedRestaurants> {
  RestaurantModel rm = RestaurantModel(
      id: "id",
      name: "name",
      description: "description",
      phone: "phone",
      address: "address",
      postalCode: "postalCode",
      municipality: "municipality",
      province: "province",
      country: "country",
      latitude: "latitude",
      longitude: "longitude",
      web: "web",
      tags: ["tags"],
      status: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      favorite: 0,
      rating: "4.5",
      schedule: []);

  Widget tableListDialog() {
    return SizedBox(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          _confirmExchange() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Intercambiar mesa'),
                    content: Text(
                        '¿Estás seguro de que quieres intercambiar con la mesa $index?'),
                    actions: [
                      TextButton(
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "Sí, intercambiar mesa",
                        ),
                        onPressed: () {},
                      ),
                    ],
                  );
                });
          }

          return Container(
              child: InkWell(
                onTap: _confirmExchange,
                child: ListTile(title: Text('Mesa $index - (2 personas)')),
              ),
              decoration:
                  const BoxDecoration(border: Border(bottom: BorderSide())));
        },
      ),
    );
  }

  Widget newTableDialog() {
    return SizedBox(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView(
          children: [
            Image.asset(
              "assets/table.png",
              height: 90,
            ),
            TextField(
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
                hintText: "Nombre de la mesa",
                label: Text("Nombre de la mesa",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 11, color: textDrkgray)),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
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
                hintText: "Número de personas",
                label: Text("Número de personas",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 11, color: textDrkgray)),
              ),
            ),
            SizedBox(height: 25),
            LargeButton(
                text: "Crear mesa",
                isWhite: true,
                onTap: () {
                  // if ()
                  // Navigator.of(context).pop();
                })
          ],
        ));
  }

  _addNewTable() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Crear nueva mesa'),
            content: newTableDialog(),
            actions: [
              TextButton(
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OwnedRestaurantDetails(
                    restaurante: rm,
                  )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 29,
        ),
        backgroundColor: Colors.orange,
        tooltip: 'Agregar nueva mesa',
        elevation: 5,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            RestaurantHeader(
              title: "Mis Restaurantes",
              subtitle: "",
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OwnedRestaurantDetails(
                                  restaurante: rm,
                                )));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 2, child: logo(250)),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text("Azurmendi",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: textDrkgray,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ],
                                      ),
                                      RatingBarIndicator(
                                        rating: double.parse("4.5"),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: textBold,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/icons/location.svg",
                                        fit: BoxFit.scaleDown,
                                        width: 9,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Text("Malaga, Malaga",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: textDrkgray,
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                            )),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  Text("El mejor restaurante de Málaga",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: textDrkgray.withOpacity(0.5),
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
