import 'package:flutter/material.dart';

import '../../presentation/home/home_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../utils/logs.dart';

typedef OOTWidgetBuilder = Widget Function(BuildContext);

class RouteList {
  static const String splash = 'splash';
  static const String home = 'home';
}

class Routes {
  static Map<String, OOTWidgetBuilder> getAll() => _routes;

  static final Map<String, OOTWidgetBuilder> _routes = {
    RouteList.splash: (context) => SplashScreen(),
  };

  static Route getRouteGenerate(RouteSettings settings) {
    var routingData = settings.name!.getRoutingData;

    printLog('[🧬Builder RouteGenerate] ${routingData.route}');
    final arguments = settings.arguments;

    switch (routingData.route) {
      case RouteList.home:
        return _buildRouteFade(settings, HomeScreen());

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute([String message = 'Page not founds']) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(message),
        ),
      );
    });
  }

  static PageRouteBuilder _buildRouteFade(
    RouteSettings settings,
    Widget builder,
  ) {
    return _FadedTransitionRoute(
      settings: settings,
      widget: builder,
    );
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, WidgetBuilder builder, {bool fullscreenDialog = false}) {
    return MaterialPageRoute(
      settings: settings,
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget? widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({this.widget, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget!;
          },
          transitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
}

extension StringExtensions on String {
  RoutingData get getRoutingData {
    final uriData = Uri.parse(this);
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}

class RoutingData {
  final String? route;
  final Map<String, String>? _queryParameters;

  RoutingData({
    this.route,
    Map<String, String>? queryParameters,
  }) : _queryParameters = queryParameters;

  String? getPram(String key) => _queryParameters![key];
}
