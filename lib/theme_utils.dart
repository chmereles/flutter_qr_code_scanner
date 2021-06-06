import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.greenAccent[400],
  //
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: Colors.greenAccent[400],
      side: BorderSide(color: Colors.greenAccent[400]!, width: 1.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
    ),
  ),

  //
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.black,
    ),
  ),

  //
  // iconTheme: IconThemeData(color: Colors.red),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.blue,
  //
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: Colors.blue,
      side: BorderSide(color: Colors.blue, width: 1.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
    ),
  ),

  //
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
    ),
  ),
);
