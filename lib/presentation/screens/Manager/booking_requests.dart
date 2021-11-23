import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/bloc/owned_restaurants_bloc.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingRequests extends StatefulWidget {
  BookingRequests({Key? key}) : super(key: key);

  @override
  _BookingRequestsState createState() => _BookingRequestsState();
}

class _BookingRequestsState extends State<BookingRequests> {
  Widget tableListDialog(state) {
    if (state is ReadyRestaurantTables) {
      return SizedBox(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.tables.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: InkWell(
                  child: ListTile(title: Text('Mesa $index - (2 personas)')),
                ),
                decoration:
                    const BoxDecoration(border: Border(bottom: BorderSide())));
          },
        ),
      );
    } else {
      return const Expanded(child: LoadWidget());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TablesBloc, TablesState>(builder: (context, state) {
      return Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            RestaurantHeader(
              title: "Solicitudes",
              subtitle: "Azurmendi",
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                itemCount: 10,
                itemBuilder: (context, index) {
                  _acceptRequest() {
                    showDialog(
                        context: context,
                        builder: (BuildContext contextDialog) {
                          return AlertDialog(
                            title: const Text('Asigna una Mesa'),
                            content: tableListDialog(state),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                onPressed: () {
                                  Navigator.of(contextDialog).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Asignar más tarde"),
                                onPressed: () {
                                  BlocProvider.of<TablesBloc>(context).add(
                                      LoadRestaurantTables(
                                          user: new User(), restaurantId: ""));
                                },
                              )
                            ],
                          );
                        });
                  }

                  _confirmAction() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('¿Quieres rechazar la reserva?'),
                            content: Text(
                                "Una vez rechazada la reservación no se podrá recuperar"),
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
                                  "Rechazar reservación",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {},
                              )
                            ],
                          );
                        });
                  }

                  return BookingRequestCard(
                    id: index.toString(),
                    onAcceptButton: _acceptRequest,
                    onRejectButton: _confirmAction,
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
