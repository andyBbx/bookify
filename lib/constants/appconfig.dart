import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

double _cornerRadius = 54;

enum DeviceType { Phone, Tablet }

bool isTab() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  return data.size.shortestSide > 550;
}
