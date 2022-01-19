import 'package:bookify/data/models/owned_restaurant.dart';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/booking_requests/booking_requests_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/CurrentRestaurant/bloc/current_restaurant_bloc.dart';
import 'package:bookify/presentation/screens/Manager/OwnedRestaurants/bloc/owned_restaurants_bloc.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/error_message.dart';
import 'package:bookify/presentation/widgets/no_data_yet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingRequests extends StatelessWidget {
  final Function tabListener;
  BookingRequests({Key? key, required this.tabListener}) : super(key: key);
  List<ReservationModel> bookingList = [];
  BookingsBloc bookingsBloc = BookingsBloc();
  BookingRequestsBloc bookingRequestsBloc = BookingRequestsBloc();
  String currentRestaurantId = "--";

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
  Widget build(BuildContext baseContext) {
    bookingsBloc = BlocProvider.of(baseContext);
    bookingRequestsBloc = BlocProvider.of(baseContext);
    return BlocBuilder<TablesBloc, TablesState>(builder: (context, state) {
      return Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            BlocBuilder<CurrentRestaurantBloc, CurrentRestaurantState>(
                builder: (context, state) {
              if (state is SettingCurrentRestaurant) {
                return RestaurantHeader(
                  title: "Solicitudes",
                  subtitle: "...",
                );
              } else if (state is DoneSettingCurrentRestaurant) {
                currentRestaurantId = state.restaurant.id;
                return RestaurantHeader(
                  title: "Solicitudes",
                  subtitle: state.restaurant.name,
                );
              } else {
                return RestaurantHeader(
                  title: "Mesas",
                  subtitle:
                      "Selecciona un restaurante para poder gestionar sus reservas, solicitudes, etc.",
                  hasAction: true,
                  action: (){
                    tabListener(3);
                  },
                  actionText: "Administrar restaurante(s)",
                );
              }
            }),
            BlocBuilder<BookingRequestsBloc, BookingRequestsState>(
                bloc: bookingRequestsBloc,
                builder: (context, state) {
                  if (state is LoadingUnconfirmedBookings) {
                    return const Expanded(child: LoadWidget());
                  } else if (state is FailedLoadingUnconfirmedBookings) {
                    return ErrorMessage(errorMessage: state.message);
                  } else if (state is UnconfirmedBookingListReady) {
                    bookingList = state.bookings;
                  }

                  if (bookingList.isNotEmpty) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<BookingRequestsBloc>(context).add(
                              LoadUnconfirmedBookings(
                                  restaurantId: currentRestaurantId));
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          itemCount: bookingList.length,
                          itemBuilder: (context, index) {
                            _acceptRequestBU() {
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
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          onPressed: () {
                                            Navigator.of(contextDialog).pop();
                                          },
                                        ),
                                        TextButton(
                                          child:
                                              const Text("Asignar más tarde"),
                                          onPressed: () {
                                            BlocProvider.of<TablesBloc>(context)
                                                .add(LoadRestaurantTables(
                                                    restaurantId: currentRestaurantId));
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }

                            _acceptRequest() {
                              BlocProvider.of<BookingsBloc>(baseContext)
                                  .add(ResetBookingsInstance());
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return BlocBuilder<BookingsBloc,
                                            BookingsState>(
                                        bloc: bookingsBloc,
                                        builder: (context, state) {
                                          if (state is UpdatingBooking) {
                                            //return const LoadWidget();
                                            return AlertDialog(
                                              title: const Text(
                                                  'Aceptando reserva'),
                                              content: Container(
                                                height: 50,
                                                width: 50,
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                            );
                                          } else if (state
                                              is DoneUpdatingBooking) {
                                            WidgetsBinding.instance!
                                                .addPostFrameCallback((_) {
                                              Navigator.pop(context);
                                              BlocProvider.of<BookingsBloc>(
                                                      baseContext)
                                                  .add(LoadConfirmedBookings(
                                                      restaurantId:
                                                          currentRestaurantId));
                                              BlocProvider.of<
                                                          BookingRequestsBloc>(
                                                      baseContext)
                                                  .add(LoadUnconfirmedBookings(
                                                      restaurantId:
                                                          currentRestaurantId));
                                            });
                                            return SizedBox();
                                          } else if (state
                                              is LoadingConfirmedBookings) {
                                            return const SizedBox();
                                          } else {
                                            return AlertDialog(
                                              title: const Text(
                                                  '¿Quieres aceptar la reserva?'),
                                              content: const Text(
                                                  'Una vez aceptada la puedes gestionar desde la pestaña de "Reservas"'),
                                              actions: [
                                                TextButton(
                                                  child: const Text(
                                                    "Cancelar",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                    "Aceptar reserva",
                                                  ),
                                                  onPressed: () {
                                                    bookingList[index].status =
                                                        2;
                                                    BlocProvider.of<
                                                                BookingsBloc>(
                                                            baseContext)
                                                        .add(UpdateBookingStatus(
                                                            booking:
                                                                bookingList[
                                                                    index]));
                                                  },
                                                )
                                              ],
                                            );
                                          }
                                        });
                                  });
                            }

                            _confirmAction() {
                              BlocProvider.of<BookingsBloc>(baseContext)
                                  .add(ResetBookingsInstance());
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return BlocBuilder<BookingsBloc,
                                            BookingsState>(
                                        bloc: bookingsBloc,
                                        builder: (context, state) {
                                          if (state is UpdatingBooking) {
                                            //return const LoadWidget();
                                            return AlertDialog(
                                              title: const Text(
                                                  'Cancelando reserva'),
                                              content: Container(
                                                height: 50,
                                                width: 50,
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                            );
                                          } else if (state
                                              is DoneUpdatingBooking) {
                                            WidgetsBinding.instance!
                                                .addPostFrameCallback((_) {
                                              Navigator.pop(context);
                                              BlocProvider.of<
                                                          BookingRequestsBloc>(
                                                      baseContext)
                                                  .add(LoadUnconfirmedBookings(
                                                      restaurantId:
                                                          currentRestaurantId));
                                            });
                                            return SizedBox();
                                          } else {
                                            return AlertDialog(
                                              title: const Text(
                                                  '¿Quieres rechazar la reserva?'),
                                              content: const Text(
                                                  "Una vez rechazada esta reserva no se podrá recuperar"),
                                              actions: [
                                                TextButton(
                                                  child: const Text(
                                                    "No rechazar",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                    "Confirmo el rechazo",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    bookingList[index].status =
                                                        3;
                                                    BlocProvider.of<
                                                                BookingsBloc>(
                                                            baseContext)
                                                        .add(UpdateBookingStatus(
                                                            booking:
                                                                bookingList[
                                                                    index]));
                                                  },
                                                )
                                              ],
                                            );
                                          }
                                        });
                                  });
                            }

                            return BookingRequestCard(
                              booking: bookingList[index],
                              onAcceptButton: _acceptRequest,
                              onRejectButton: _confirmAction,
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return NotDataYet(
                        message: "¡No hay solicitudes aún!",
                        retryAction: () {
                          BlocProvider.of<BookingRequestsBloc>(context).add(
                              LoadUnconfirmedBookings(
                                  restaurantId: currentRestaurantId));
                        });
                  }
                }),
          ],
        ),
      );
    });
  }
}
