import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/infrastructure/repostories/repositories.dart';
import 'package:timer_app/presentation/my_app.dart';
import 'package:timer_app/presentation/providers/cart_provider.dart';
import 'package:timer_app/presentation/providers/providers.dart';

Future<void> main() async {
  Dio dioInstance = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com/"));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CountdownProvider()),
      ChangeNotifierProvider(create: (_) => DarkmodeProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      Provider<ProductRepository>(
          create: (_) => ProductRepository(dioInstance)),
      Provider<CartRepository>(create: (_) => CartRepository(dioInstance)),
      Provider<Logger>(
          create: (_) => Logger(
                printer: PrettyPrinter(),
                level: kDebugMode ? Level.verbose : Level.nothing,
              ))
    ],
    builder: (context, _) {
      return const MyApp();
    },
  ));
}
