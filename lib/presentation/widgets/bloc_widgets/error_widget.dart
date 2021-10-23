import 'package:flutter/material.dart';

class ErrorBlocWidget extends StatelessWidget {
  final String errorText;

  const ErrorBlocWidget({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 10),
          Text(errorText)
        ],
      ),
    );
  }
}
