import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:flutter/material.dart';

class BookingRequests extends StatefulWidget {
  BookingRequests({Key? key}) : super(key: key);

  @override
  _BookingRequestsState createState() => _BookingRequestsState();
}

class _BookingRequestsState extends State<BookingRequests> {
  Widget tableListDialog() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
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
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              itemCount: 10,
              itemBuilder: (context, index) {
                _simpleFunction() {
                  //print(index);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Asigna una Mesa'),
                          content: tableListDialog(),
                          actions: [
                            TextButton(
                              child: const Text("Cancelar", style: TextStyle(color: Colors.grey),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Asignar más tarde"),
                              onPressed: () {},
                            )
                          ],
                        );
                      });
                }

                _confirmAction() {
                  //print(index);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('¿Quieres rechazar la reserva?'),
                          content: Text("Una vez rechazada la reservación no se podrá recuperar"),
                          actions: [
                            TextButton(
                              child: const Text("Cancelar", style: TextStyle(color: Colors.grey),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Rechazar reservación", style: TextStyle(color: Colors.red),),
                              onPressed: () {},
                            )
                          ],
                        );
                      });
                }

                return BookingRequestCard(
                  id: index.toString(),
                  onTap: _simpleFunction,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
