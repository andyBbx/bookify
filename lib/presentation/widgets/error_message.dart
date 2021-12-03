import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  const ErrorMessage({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
