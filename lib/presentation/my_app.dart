import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timer_app/presentation/pages/pages.dart';
import 'package:timer_app/presentation/providers/providers.dart';
import 'package:timer_app/presentation/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = "Kennet's App";

  @override
  Widget build(BuildContext context) {
    DarkmodeProvider darkModeProvider =
    Provider.of<DarkmodeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            themeMode: darkModeProvider.mode,
            home: HomePage(title: title),
          );
  }
}