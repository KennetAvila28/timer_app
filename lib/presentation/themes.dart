import 'package:flutter/material.dart';

class MyThemes {

  //-------------DARK THEME SETTINGS----
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black45,
    colorScheme:  const ColorScheme.dark(),
  useMaterial3: true
  );


  //-------------light THEME SETTINGS----
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
    ),
    colorScheme:  const ColorScheme.light(),
  );

}