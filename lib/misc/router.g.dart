// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $baseRoute,
    ];

RouteBase get $baseRoute => GoRouteData.$route(
      path: '/',
      factory: $BaseRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'board',
          factory: $BoardRouteExtension._fromState,
        ),
        ShellRouteData.$route(
          factory: $GameMenuShellRouteExtension._fromState,
          navigatorKey: GameMenuShellRoute.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: 'home',
              factory: $HomeRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'settings',
              factory: $SettingsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'levels',
              factory: $LevelsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $BaseRouteExtension on BaseRoute {
  static BaseRoute _fromState(GoRouterState state) => const BaseRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $BoardRouteExtension on BoardRoute {
  static BoardRoute _fromState(GoRouterState state) => const BoardRoute();

  String get location => GoRouteData.$location(
        '/board',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $GameMenuShellRouteExtension on GameMenuShellRoute {
  static GameMenuShellRoute _fromState(GoRouterState state) =>
      const GameMenuShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $LevelsRouteExtension on LevelsRoute {
  static LevelsRoute _fromState(GoRouterState state) => const LevelsRoute();

  String get location => GoRouteData.$location(
        '/levels',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
