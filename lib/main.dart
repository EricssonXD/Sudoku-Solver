import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku_solver/misc/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      title: "YEET",
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  debugLogDiagnostics: true,
  routes: $appRoutes,
  navigatorKey: $rootNavigatorKey,
  redirect: (BuildContext context, GoRouterState state) {
    return null;
  },
);
