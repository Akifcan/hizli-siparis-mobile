import 'package:flutter/material.dart';

ThemeData authTheme = ThemeData(
    scaffoldBackgroundColor: Colors.red[700],
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
    ),
    hintColor: Colors.white);

ThemeData mainTheme = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.indigo),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
        headline4: TextStyle(color: Colors.black),
        headline5: TextStyle(color: Colors.white),
        headline6: TextStyle(color: Colors.black)),
    scaffoldBackgroundColor: Color(0xffdedede));
