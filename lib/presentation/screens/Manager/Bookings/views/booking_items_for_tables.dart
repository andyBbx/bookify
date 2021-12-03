import 'dart:convert';
import 'package:bookify/data/models/reservation.dart';
import 'package:bookify/data/models/table.dart';
import 'package:bookify/data/service/service.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/booking_requests/booking_requests_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/CommonWidgets/restaurant_header.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card_for_table.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_item_card_for_table_swap.dart';
import 'package:bookify/presentation/screens/Manager/SpecificWidgets/booking_request_card.dart';
import 'package:bookify/presentation/screens/Manager/Table/bloc/table_bloc.dart';
import 'package:bookify/presentation/screens/Manager/TableBookings/bloc/table_bookings_bloc.dart';
import 'package:bookify/presentation/screens/Manager/Tables/bloc/tables_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:bookify/presentation/widgets/error_message.dart';
import 'package:bookify/presentation/widgets/no_data_yet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingItemsForTables extends StatelessWidget {
  final TableModel table;
  BookingItemsForTables({Key? key, required this.table}) : super(key: key);
  TableBookingsBloc tableBookingsBloc = TableBookingsBloc();
  BookingsBloc bookingsBloc = BookingsBloc();
  List<ReservationModel> bookingList = [];
  List<ReservationModel> restaurantBookingList = [];
  List<TableModel> tables = [];

  TablesBloc tablesBloc = TablesBloc();
  TableBloc tableBloc = TableBloc();

  Widget tableListToAssign(baseContext, ReservationModel booking) {
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
                if (state is ConfirmedBookingListReady) {
                  restaurantBookingList = state.bookings;
                }
                return BlocBuilder<TableBookingsBloc, TableBookingsState>(
                    bloc: tableBookingsBloc,
                    builder: (context, state) {
                      if (state is AssigningTable) {
                        return const LoadWidget();
                      } else if (state is DoneAssigningTable) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.pop(context);
                          BlocProvider.of<BookingsBloc>(baseContext).add(
                              LoadConfirmedBookings(
                                  restaurantId: table.restaurant_id));
                        });
                        return const SizedBox();
                      } else if (state is LoadingConfirmedBookings) {
                        return const SizedBox();
                      } else {
                        if (tables.isNotEmpty) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(10),
                            height: 300.0,
                            width: 300.0,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: restaurantBookingList.length,
                              itemBuilder: (BuildContext context, int index) {
                                swapTable(
                                    destinationBookingId, destinationTableId) {
                                  BlocProvider.of<TableBloc>(baseContext).add(
                                      SwapTable(
                                          originBookingId: booking.id,
                                          originTableId: table.id,
                                          destinationBookingId:
                                              destinationBookingId,
                                          destinationTableId:
                                              destinationTableId));
                                }

                                if (restaurantBookingList[index].id ==
                                    booking.id) {
                                  return SizedBox();
                                }

                                return BookingItemCardForTableSwap(
                                  booking: restaurantBookingList[index],
                                  onTableChangeButton: swapTable,
                                  onCancelButton: () {},
                                  assignedTables: () {},
                                );
                              },
                            ),
                          );
                        } else {
                          return NotDataYet(
                              message: "Aún no hay mesas para asignar",
                              retryAction: () {
                                BlocProvider.of<TablesBloc>(context).add(
                                    const LoadRestaurantTables(
                                        restaurantId: ""));
                              });
                        }
                      }
                    });
              });
        });
  }

  Widget tableListToRemove(
      bookingTables, baseContext, ReservationModel booking) {
    return BlocBuilder<TableBookingsBloc, TableBookingsState>(
        bloc: tableBookingsBloc,
        builder: (context, state) {
          if (state is AssigningTable) {
            return const LoadWidget();
          } else if (state is DoneAssigningTable) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pop(context);
              BlocProvider.of<BookingsBloc>(baseContext).add(
                  LoadConfirmedBookings(restaurantId: table.restaurant_id));
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
    tableBookingsBloc = BlocProvider.of(baseContext);
    bookingsBloc = BlocProvider.of(baseContext);
    tablesBloc = BlocProvider.of(baseContext);
    tableBloc = BlocProvider.of(baseContext);

    reloadLists() {
      BlocProvider.of<TableBookingsBloc>(baseContext)
          .add(LoadTableBookings(tableId: table.id));
      BlocProvider.of<TablesBloc>(baseContext)
          .add(LoadRestaurantTables(restaurantId: table.restaurant_id));
      BlocProvider.of<BookingRequestsBloc>(baseContext)
          .add(LoadUnconfirmedBookings(restaurantId: table.restaurant_id));
      BlocProvider.of<BookingsBloc>(baseContext)
          .add(LoadConfirmedBookings(restaurantId: table.restaurant_id));
    }

    return BlocBuilder<TablesBloc, TablesState>(
        bloc: tablesBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: Text(
                'Mesa "${table.name}"',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: Column(
                children: [
                  BlocBuilder<TableBookingsBloc, TableBookingsState>(
                      bloc: tableBookingsBloc,
                      builder: (context, state) {
                        if (state is LoadingTableBookings) {
                          return const Expanded(child: LoadWidget());
                        } else if (state is FailedLoadingTableBookings) {
                          return ErrorMessage(errorMessage: state.message);
                        } else if (state is TableBookingListReady) {
                          bookingList = state.bookings;
                        }
                        if (bookingList.isNotEmpty) {
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                BlocProvider.of<TableBookingsBloc>(context)
                                    .add(LoadTableBookings(tableId: table.id));
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
                                    BlocProvider.of<TableBloc>(baseContext)
                                        .add(ResetTableInstance());
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return BlocBuilder<TableBloc,
                                                  TableState>(
                                              bloc: tableBloc,
                                              builder: (context, state) {
                                                if (state is SwappingTable) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Intercambiando reserva'),
                                                    content: Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    ),
                                                  );
                                                } else if (state
                                                    is FailedSwappingTable) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Hubo un error'),
                                                    content: Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: Text(
                                                        state.message,
                                                        style: const TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text(
                                                          "Cerrar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                } else if (state
                                                    is DoneSwappingTable) {
                                                  reloadLists();
                                                  WidgetsBinding.instance!
                                                      .addPostFrameCallback(
                                                          (_) {
                                                    Navigator.pop(context);
                                                  });
                                                  return SizedBox();
                                                } else {
                                                  return AlertDialog(
                                                    /* contentPadding: EdgeInsets.all(10),
                                          titlePadding: EdgeInsets.all(10), */
                                                    insetPadding:
                                                        EdgeInsets.all(15),
                                                    title: const Text(
                                                        'Intercambiar mesa'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            "Selecciona la mesa con la que quieres intercambiar"),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        tableListToAssign(
                                                            baseContext,
                                                            bookingList[index]),
                                                      ],
                                                    ),
                                                    actions: [
                                                      BlocBuilder<
                                                              TableBookingsBloc,
                                                              TableBookingsState>(
                                                          bloc:
                                                              tableBookingsBloc,
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is AssigningTable) {
                                                              return const SizedBox();
                                                            } else {
                                                              return TextButton(
                                                                child:
                                                                    const Text(
                                                                  "Cancelar",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              );
                                                            }
                                                          }),
                                                    ],
                                                  );
                                                }
                                              });
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
                                            title:
                                                const Text('Mesas asignadas'),
                                            content: tableListToRemove(
                                                bookingTables,
                                                baseContext,
                                                bookingList[index]),
                                            actions: [
                                              BlocBuilder<TableBookingsBloc,
                                                      TableBookingsState>(
                                                  bloc: tableBookingsBloc,
                                                  builder: (context, state) {
                                                    if (state
                                                        is AssigningTable) {
                                                      return const SizedBox();
                                                    } else {
                                                      return TextButton(
                                                        child: const Text(
                                                          "Cancelar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
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
                                          return BlocBuilder<TableBookingsBloc,
                                                  TableBookingsState>(
                                              bloc: tableBookingsBloc,
                                              builder: (context, state) {
                                                if (state is ClearingTable) {
                                                  //return const LoadWidget();
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Desasignando reserva'),
                                                    content: Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    ),
                                                  );
                                                } else if (state
                                                    is DoneClearingTable) {
                                                  WidgetsBinding.instance!
                                                      .addPostFrameCallback(
                                                          (_) {
                                                    Navigator.pop(context);
                                                    reloadLists();
                                                  });
                                                  return SizedBox();
                                                } else if (state
                                                    is LoadingTableBookings) {
                                                  return const SizedBox();
                                                } else {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        '¿Quieres desasignar esta reserva?'),
                                                    content: const Text(
                                                        'En caso de ser necesario la puedes reasignar en la pestaña de "Reservas"'),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text(
                                                          "Cancelar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                          "Sí, desasignar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        onPressed: () {
                                                          bookingList[index]
                                                              .status = 3;
                                                          BlocProvider.of<
                                                                      TableBookingsBloc>(
                                                                  baseContext)
                                                              .add(ClearTableFromBooking(
                                                                  tableId:
                                                                      table.id,
                                                                  bookingId:
                                                                      bookingList[
                                                                              index]
                                                                          .id));
                                                        },
                                                      )
                                                    ],
                                                  );
                                                }
                                              });
                                        });
                                  }

                                  return BookingItemCardForTable(
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
                                BlocProvider.of<TableBookingsBloc>(context)
                                    .add(LoadTableBookings(tableId: table.id));
                              });
                        }
                      }),
                ],
              ),
            ),
          );
        });
  }
}
