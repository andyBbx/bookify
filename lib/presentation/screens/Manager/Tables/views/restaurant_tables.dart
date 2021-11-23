import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/table.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/table_item_card.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/large_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RestaurantTables extends StatefulWidget {
  final User user;
  const RestaurantTables({Key? key, required this.user}) : super(key: key);

  @override
  _RestaurantTablesState createState() => _RestaurantTablesState();
}

class _RestaurantTablesState extends State<RestaurantTables> {

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
        onPressed: (){
          BlocProvider.of<TablesBloc>(context)
        .add(LoadRestaurantTables(user: widget.user, restaurantId: ""));
        },
        //_addNewTable,
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
              title: "Mesas",
              subtitle: "Azurmendi",
            ),
            BlocBuilder<TablesBloc, TablesState>(builder: (context, state) {
              if (state is LoadingRestaurantTables) {
                return const Expanded(child: LoadWidget());
              } else if (state is ReadyRestaurantTables) {
                return Flexible(
                  child: GridView.builder(
                      padding: EdgeInsets.all(15),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 5),
                      itemCount: state.tables.length,
                      itemBuilder: (BuildContext ctx, index) {
                        TableModel table = state.tables[index];

                        _markAsBusy() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Ocupar mesa'),
                                  content: Text(
                                      '¿Quieres marcar la mesa '+table.name+' cómo ocupada?'),
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
                                        "Sí, ocupar mesa",
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                );
                              });
                        }

                        _freeTable() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Liberar mesa'),
                                  content: Text(
                                      '¿Estás seguro de que quieres liberar la mesa '+table.name+'?'),
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
                                        "Liberar mesa",
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                );
                              });
                        }

                        _exchangeTable() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Intercambiar mesa con'),
                                  content: tableListDialog(),
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

                        return TableItem(
                          tableModel: table,
                          onAvailableTap: _markAsBusy,
                          onBusyTap: _freeTable,
                          onExchangeTap: _exchangeTable,
                        );
                      }),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
