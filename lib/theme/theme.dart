import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  colorScheme:  ColorScheme.light(
    surface: Color(0xFFEDF4F2), //background color
    primary: Color(0xFF31473A), //widget color
    secondary: Colors.grey.shade800, //icon or general text
    inversePrimary: Color(0xFFEDF4F2), //text color (in buttons)
  ),
);