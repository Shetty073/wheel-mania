import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    textTheme: TextTheme(
      body1: TextStyle(
        color: Colors.black,
      ),
      body2: TextStyle(
        color: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.black,
    textTheme: TextTheme(
      body1: TextStyle(
        color: Colors.white,
      ),
      body2: TextStyle(
        color: Colors.grey[700],
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  );
}
