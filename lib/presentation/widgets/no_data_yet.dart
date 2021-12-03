import 'package:bookify/presentation/screens/Manager/Bookings/bloc/bookings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotDataYet extends StatelessWidget {
  final String message;
  final Function retryAction;
  const NotDataYet({Key? key, required this.message, required this.retryAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          TextButton(
            onPressed: () {
              retryAction();
            },
            child: Text("Recargar"),
          ),
        ],
      ),
    );
  }
}
