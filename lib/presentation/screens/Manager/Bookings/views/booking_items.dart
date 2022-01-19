import 'dart:convert';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/table.dart';
import 'package:bookify/data/service/service.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/CurrentRestaurant/bloc/current_restaurant_bloc.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/error_message.dart';
import 'package:bookify/presentation/widgets/no_data_yet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingItems extends StatelessWidget {
  final Function tabListener;
  BookingItems({Key? key, required this.tabListener}) : super(key: key);
  BookingsBloc bookingsBloc = BookingsBloc();
  List<ReservationModel> bookingList = [];
  List<TableModel> tables = [];
  String currentRestaurantId = "--";

  TablesBloc tablesBloc = TablesBloc();

  Widget tableListToAssign(baseContext, booking) {
    return BlocBuilder<TablesBloc, TablesState>(
        bloc: tablesBloc,
        builder: (context, state) {
          if (state is LoadingRestaurantTables) {
            return const Expanded(child: LoadWidget());
          } else if (state is FailedLoadingRestaurantTables) {
            return ErrorMessage(errorMessage: state.message);
          } else if (state is ReadyRestaurantTables) {
            tables = state.tables;
          }

          return BlocBuilder<BookingsBloc, BookingsState>(
              bloc: bookingsBloc,
              builder: (context, state) {
                if (state is AssigningTable) {
                  return const LoadWidget();
                } else if (state is DoneAssigningTable) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    Navigator.pop(context);
                    BlocProvider.of<BookingsBloc>(baseContext).add(
                        LoadConfirmedBookings(
                            restaurantId: currentRestaurantId));
                    BlocProvider.of<TablesBloc>(baseContext).add(
                        LoadRestaurantTables(
                            restaurantId: currentRestaurantId));
                  });
                  return const SizedBox();
                } else if (state is LoadingConfirmedBookings) {
                  return const SizedBox();
                } else {
                  if (tables.isNotEmpty) {
                    return SizedBox(
                      height: 300.0, // Change as per your requirement
                      width: 300.0, // Change as per your requirement
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: tables.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<BookingsBloc>(baseContext)
                                      .add(AssignTable(
                                          removingTable: false,
                                          booking: booking,
                                          tableId: tables[index].id));
                                  //_assignTable(baseContext, booking, tables[index].id);
                                },
                                child: ListTile(
                                    title: Text(
                                        '${tables[index].name} - (${tables[index].quantity} personas)')),
                              ),
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide())));
                        },
                      ),
                    );
                  } else {
                    return NotDataYet(
                        message: "Aún no hay mesas para asignar",
                        retryAction: () {
                          BlocProvider.of<TablesBloc>(baseContext).add(
                              LoadRestaurantTables(
                                  restaurantId: currentRestaurantId));
                        });
                  }
                }
              });
        });
  }

  Widget tableListToRemove(bookingTables, baseContext, booking) {
    return BlocBuilder<BookingsBloc, BookingsState>(
        bloc: bookingsBloc,
        builder: (context, state) {
          if (state is AssigningTable) {
            return const LoadWidget();
          } else if (state is DoneAssigningTable) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pop(context);
              BlocProvider.of<BookingsBloc>(baseContext).add(
                  LoadConfirmedBookings(restaurantId: currentRestaurantId));
              BlocProvider.of<TablesBloc>(baseContext)
                  .add(LoadRestaurantTables(restaurantId: currentRestaurantId));
            });
            return const SizedBox();
          } else if (state is LoadingConfirmedBookings) {
            return const SizedBox();
          } else {
            if (bookingTables.isNotEmpty) {
              return SizedBox(
                height: 150.0, // Change as per your requirement
                width: 150.0, // Change as per your requirement
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bookingTables.length,
                  itemBuilder: (BuildContext context, int tableIndex) {
                    return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 5,
                              child: Text(
                                  '${bookingTables[tableIndex].name} - (${bookingTables[tableIndex].quantity} personas)'),
                            ),
                            Flexible(
                                flex: 3,
                                child: TextButton(
                                    onPressed: () {
                                      BlocProvider.of<BookingsBloc>(baseContext)
                                          .add(AssignTable(
                                              removingTable: true,
                                              booking: booking,
                                              tableId: bookingTables[tableIndex]
                                                  .id));
                                    },
                                    child: Text(
                                      "Eliminar",
                                      style: TextStyle(color: Colors.red),
                                    )))
                          ],
                        ),
                        padding: EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey))));
                  },
                ),
              );
            } else {
              return SizedBox(
                height: 100.0, // Change as per your requirement
                width: 100.0,
                child: Center(
                    child: Text(
                  "La reservación aún no tiene mesas asignadas",
                  textAlign: TextAlign.center,
                )),
              );
            }
          }
        });
  }

  @override
  Widget build(BuildContext baseContext) {
    bookingsBloc = BlocProvider.of(baseContext);
    tablesBloc = BlocProvider.of(baseContext);

    return BlocBuilder<TablesBloc, TablesState>(
        bloc: tablesBloc,
        builder: (context, state) {
          return Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                BlocBuilder<CurrentRestaurantBloc, CurrentRestaurantState>(
                    builder: (context, state) {
                  if (state is SettingCurrentRestaurant) {
                    return RestaurantHeader(
                      title: "Reservas",
                      subtitle: "...",
                    );
                  } else if (state is DoneSettingCurrentRestaurant) {
                    currentRestaurantId = state.restaurant.id;
                    return RestaurantHeader(
                      title: "Reservas",
                      subtitle: state.restaurant.name,
                    );
                  } else {
                    return RestaurantHeader(
                      title: "Mesas",
                      subtitle:
                          "Selecciona un restaurante para poder gestionar sus reservas, solicitudes, etc.",
                      hasAction: true,
                      action: () {
                        tabListener(3);
                      },
                      actionText: "Administrar restaurante(s)",
                    );
                  }
                }),
                BlocBuilder<BookingsBloc, BookingsState>(
                    bloc: bookingsBloc,
                    builder: (context, state) {
                      if (state is LoadingConfirmedBookings) {
                        return const Expanded(child: LoadWidget());
                      } else if (state is FailedLoadingConfirmedBookings) {
                        return ErrorMessage(errorMessage: state.message);
                      } else if (state is ConfirmedBookingListReady) {
                        bookingList = state.bookings;
                      }
                      if (bookingList.isNotEmpty) {
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              BlocProvider.of<BookingsBloc>(context).add(
                                  LoadConfirmedBookings(
                                      restaurantId: currentRestaurantId));
                            },
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              itemCount: bookingList.length,
                              itemBuilder: (context, index) {
                                List<String> tableIds = [];
                                List<TableModel> bookingTables = [];
                                for (var i = 0;
                                    i < bookingList[index].tables.length;
                                    i++) {
                                  bookingTables.add(TableModel.fromJson(
                                      bookingList[index].tables[i]));
                                }

                                _assignTable() {
                                  BlocProvider.of<BookingsBloc>(baseContext)
                                      .add(ResetBookingsInstance());
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Asigna una Mesa'),
                                          content: tableListToAssign(
                                              baseContext, bookingList[index]),
                                          actions: [
                                            BlocBuilder<BookingsBloc,
                                                    BookingsState>(
                                                bloc: bookingsBloc,
                                                builder: (context, state) {
                                                  if (state is AssigningTable) {
                                                    return const SizedBox();
                                                  } else {
                                                    return TextButton(
                                                      child: const Text(
                                                        "Cancelar",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    );
                                                  }
                                                }),
                                          ],
                                        );
                                      });
                                }

                                seeAssignedTables() {
                                  BlocProvider.of<BookingsBloc>(baseContext)
                                      .add(ResetBookingsInstance());
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Mesas asignadas'),
                                          content: tableListToRemove(
                                              bookingTables,
                                              baseContext,
                                              bookingList[index]),
                                          actions: [
                                            BlocBuilder<BookingsBloc,
                                                    BookingsState>(
                                                bloc: bookingsBloc,
                                                builder: (context, state) {
                                                  if (state is AssigningTable) {
                                                    return const SizedBox();
                                                  } else {
                                                    return TextButton(
                                                      child: const Text(
                                                        "Cancelar",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    );
                                                  }
                                                }),
                                          ],
                                        );
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
                                                  BlocProvider.of<BookingsBloc>(
                                                          baseContext)
                                                      .add(LoadConfirmedBookings(
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
                                                      '¿Quieres cancelar esta reserva?'),
                                                  content: const Text(
                                                      "Una vez cancelada esta reservación no se podrá recuperar"),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text(
                                                        "No cancelar",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text(
                                                        "Confirmo la cancelación",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      onPressed: () {
                                                        bookingList[index]
                                                            .status = 3;
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

                                return BookingItemCard(
                                  booking: bookingList[index],
                                  onTableChangeButton: _assignTable,
                                  onCancelButton: _confirmAction,
                                  assignedTables: seeAssignedTables,
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return NotDataYet(
                            message: "¡No hay solicitudes aún!",
                            retryAction: () {
                              BlocProvider.of<BookingsBloc>(context).add(
                                  LoadConfirmedBookings(
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
