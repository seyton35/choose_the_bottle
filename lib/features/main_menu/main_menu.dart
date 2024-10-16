import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_the_bottle/domain/main_navigation/main_navigation.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE BOTTLE'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.goNamed(
                MainNavigationRouteNames.classicGame,
              ),
              child: const Text('classic'),
            )
          ],
        ),
      ),
    );
  }
}
