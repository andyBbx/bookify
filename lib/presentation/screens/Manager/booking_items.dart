import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingItems extends StatefulWidget {
  BookingItems({Key? key}) : super(key: key);

  @override
  _BookingItemsState createState() => _BookingItemsState();
}

class _BookingItemsState extends State<BookingItems> {
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
              title: "Reservaciones",
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
                        builder: (BuildContext context) {
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
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }

                  _confirmAction() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Text('¿Quieres eliminiar esta reserva?'),
                            content: const Text(
                                "Una vez eliminada esta reservación no se podrá recuperar"),
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
                                  "Eliminar reservación",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {},
                              )
                            ],
                          );
                        });
                  }

                  return BookingItemCard(
                    id: index.toString(),
                    onTableChangeButton: _acceptRequest,
                    onCancelButton: _confirmAction,
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
