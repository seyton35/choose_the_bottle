import 'package:go_router/go_router.dart';
import 'package:guess_the_bottle/features/classic_game/classic_game.dart';
import 'package:guess_the_bottle/features/main_menu/main_menu.dart';

abstract class MainNavigationRouteNames {
  static const classicGame = '/main_menu/classic_game';
  static const mainMenu = '/main_menu';
}

final GoRouter router = GoRouter(
  initialLocation: MainNavigationRouteNames.mainMenu,
  routes: [
    GoRoute(
        name: MainNavigationRouteNames.mainMenu,
        path: MainNavigationRouteNames.mainMenu,
        builder: (context, state) => const MainMenu()),
    GoRoute(
        name: MainNavigationRouteNames.classicGame,
        path: MainNavigationRouteNames.classicGame,
        builder: (context, state) => ClassicGame.create()),
  ],
);
