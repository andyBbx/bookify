import 'dart:convert';

import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/table.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/views/booking_items.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/views/booking_items_for_tables.dart';
import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/CurrentRestaurant/bloc/current_restaurant_bloc.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/table_item_card.dart';
import 'package:bookify/presentation/screens/Manager/Table/bloc/table_bloc.dart';
import 'package:bookify/presentation/screens/Manager/TableBookings/bloc/table_bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/large_button.dart';
import 'package:bookify/presentation/widgets/no_data_yet.dart';
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
  TablesBloc tablesBloc = TablesBloc();
  TableBloc tableBloc = TableBloc();
  TableModel table = TableModel(
      id: "",
      restaurant_id: "",
      name: "",
      quantity: "0",
      available: 0,
      status: 0);
  final _formKey = GlobalKey<FormState>();
  String currentRestaurantId = "";
  List<TableModel> tableList = [];

  @override
  void initState() {
    super.initState();
    tablesBloc = BlocProvider.of(context);
    tableBloc = BlocProvider.of(context);
  }

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
        width: 300.0, // Change as per your requirement
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.asset(
                "assets/table.png",
                height: 60,
              ),
              TextFormField(
                onChanged: (value) {
                  table.name = value;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Debes completar este campo';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
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
              TextFormField(
                onChanged: (value) {
                  table.quantity = value;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Debes completar este campo';
                  }
                  return null;
                },
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
              /* LargeButton(
                  text: "Crear mesa",
                  isWhite: true,
                  onTap: () {
                    BlocProvider.of<TablesBloc>(context)
                        .add(const LoadRestaurantTables(restaurantId: ""));
                    // if ()
                    // Navigator.of(context).pop();
                  }) */
            ],
          ),
        ));
  }

  _addNewTable(initialContext) {
    showDialog(
        context: initialContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Crear nueva mesa'),
            content: newTableDialog(),
            actions: [
              BlocBuilder<TableBloc, TableState>(
                  bloc: tableBloc,
                  builder: (context, state) {
                    if ((state is LoadingRestaurantTables) ||
                        (state is CreatingTable)) {
                      return TextButton(
                        child: const SizedBox(
                            height: 16,
                            width: 16,
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                            ))),
                        onPressed: () {},
                      );
                    } else if (state is DoneCreatingTable) {
                      table = TableModel(
                          id: "",
                          restaurant_id: currentRestaurantId,
                          name: "",
                          quantity: "0",
                          available: 0,
                          status: 0);

                      BlocProvider.of<TablesBloc>(initialContext).add(
                          LoadRestaurantTables(
                              restaurantId: currentRestaurantId));

                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Navigator.pop(context);
                        BlocProvider.of<TableBloc>(initialContext)
                            .add(ResetTableInstance());
                      });

                      return SizedBox();
                    } else if (state is FailedCreatingTable) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                                  "Crear mesa",
                                  style: TextStyle(color: Colors.orange),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<TableBloc>(initialContext)
                                        .add(CreateTable(table: table));
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                              "Crear mesa",
                              style: TextStyle(color: Colors.orange),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<TableBloc>(initialContext)
                                    .add(CreateTable(table: table));
                              }
                            },
                          ),
                        ],
                      );
                    }
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext baseContext) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //WidgetsBinding.instance!.addPostFrameCallback((_) => _addNewTable(context));
          /* BlocProvider.of<TablesBloc>(context)
        .add(LoadRestaurantTables(user: widget.user, restaurantId: ""));
        }, */
          _addNewTable(context);
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
            BlocBuilder<CurrentRestaurantBloc, CurrentRestaurantState>(
                builder: (context, state) {
              if (state is SettingCurrentRestaurant) {
                return RestaurantHeader(
                  title: "Mesas",
                  subtitle: "...",
                );
              } else if (state is DoneSettingCurrentRestaurant) {
                currentRestaurantId = state.restaurant.id;
                table.restaurant_id = currentRestaurantId;
                return RestaurantHeader(
                  title: "Mesas",
                  subtitle: state.restaurant.name,
                );
              } else {
                return RestaurantHeader(
                  title: "Mesas",
                  subtitle:
                      "Selecciona un restaurante para poder gestionar sus reservas, solicitudes, etc.",
                );
              }
            }),
            BlocBuilder<TablesBloc, TablesState>(
                bloc: tablesBloc,
                builder: (context, state) {
                  if (state is LoadingRestaurantTables) {
                    return const Expanded(child: LoadWidget());
                  } else if (state is ReadyRestaurantTables) {
                    tableList = state.tables;
                  }

                  if (tableList.isNotEmpty) {
                    return Flexible(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<TablesBloc>(baseContext).add(
                              LoadRestaurantTables(
                                  restaurantId: currentRestaurantId));
                        },
                        child: GridView.builder(
                            padding: EdgeInsets.all(15),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 0.9,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 5),
                            itemCount: tableList.length,
                            itemBuilder: (BuildContext ctx, index) {
                              TableModel table = tableList[index];

                              _markAsBusy() {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Ocupar mesa'),
                                        content: Text(
                                            '¿Quieres marcar la mesa ' +
                                                table.name +
                                                ' cómo ocupada?'),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              "Cancelar",
                                              style:
                                                  TextStyle(color: Colors.grey),
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
                                BlocProvider.of<TableBookingsBloc>(context)
                                    .add(LoadTableBookings(tableId: table.id));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                  value: BlocProvider.of<
                                                          BookingsBloc>(
                                                      baseContext)),
                                              BlocProvider.value(
                                                  value: BlocProvider.of<
                                                      TablesBloc>(baseContext)),
                                              BlocProvider.value(
                                                  value: BlocProvider.of<
                                                          TableBookingsBloc>(
                                                      baseContext)),
                                              BlocProvider.value(
                                                  value: BlocProvider.of<
                                                      TableBloc>(baseContext)),
                                            ],
                                            child: BookingItemsForTables(
                                              table: table,
                                            ))));
                                /* Navigator.of(baseContext)
                                    .push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<BookingsBloc>(
                                        baseContext),
                                    child: BookingItems(),
                                  ),
                                )); */
                                /* showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Liberar mesa'),
                                        content: Text(
                                            '¿Estás seguro de que quieres liberar la mesa ' +
                                                table.name +
                                                '?'),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              "Cancelar",
                                              style:
                                                  TextStyle(color: Colors.grey),
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
                                    }); */
                              }

                              _exchangeTable() {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Intercambiar mesa con'),
                                        content: tableListDialog(),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              "Cancelar",
                                              style:
                                                  TextStyle(color: Colors.grey),
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
                      ),
                    );
                  } else {
                    return NotDataYet(
                        message: "¡No hay mesas aún!",
                        retryAction: () {
                          BlocProvider.of<TablesBloc>(baseContext).add(
                              LoadRestaurantTables(
                                  restaurantId: currentRestaurantId));
                        });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
