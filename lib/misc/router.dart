import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku_solver/board/board_screen.dart';
import 'package:sudoku_solver/home/home_screen.dart';
import 'package:sudoku_solver/home/navigation_shell.dart';
import 'package:sudoku_solver/settings/settings_screen.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> $rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> $shellNavigatorKey =
    GlobalKey<NavigatorState>();

@TypedGoRoute<BaseRoute>(
  path: '/',
  routes: <TypedRoute>[
    TypedGoRoute<BoardRoute>(
      path: 'board',
    ),
    TypedShellRoute<GameMenuShellRoute>(routes: [
      TypedGoRoute<HomeRoute>(
        path: 'home',
      ),
      TypedGoRoute<SettingsRoute>(
        path: 'settings',
      ),
      TypedGoRoute<LevelsRoute>(
        path: 'levels',
      ),
    ]),
  ],
)
class BaseRoute extends GoRouteData {
  const BaseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class GameMenuShellRoute extends ShellRouteData {
  const GameMenuShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = $shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return NavBarShell(child: navigator);
  }
}

class BoardRoute extends GoRouteData {
  const BoardRoute();

  // static final GlobalKey<NavigatorState> $parentNavigatorKey =
  //     $rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Scaffold(
      body: BoardScreen(),
    );
  }
}

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

class LevelsRoute extends GoRouteData {
  const LevelsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}
