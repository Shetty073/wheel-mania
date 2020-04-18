import 'package:flutter/material.dart';

const kApiUrl = "http://192.168.1.159:5000/bike/";

const List kAppColorsList = [
  [Color(0xFFFF7F70), Color(0xFFFF2A3E)],
  [Color(0xFF9275DE), Color(0xFF4A3291)],
];

double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}


