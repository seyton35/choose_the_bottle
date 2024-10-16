import 'package:flutter/material.dart';
import 'package:guess_the_bottle/domain/main_navigation/main_navigation.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
