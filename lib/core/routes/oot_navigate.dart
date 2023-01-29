import 'package:flutter/material.dart';

/// Push screen on TabBar
class OOTNavigate {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get _rootNavigator => Navigator.of(navigatorKey.currentContext!);

  // static NavigatorState get _tabNavigator => Navigator.of(
  //     MainTabControlDelegate.getInstance().tabKey()!.currentContext!);

  static NavigatorState get _navigator => _rootNavigator;
  // kAdvanceConfig.alwaysShowTabBar ? _tabNavigator : _rootNavigator;

  static dynamic generateUri(arguments, routeName) {
    // var id =
    //     arguments is Product || arguments is Category ? arguments.id : null;

    // if (id != null) {
    //   return Uri(path: routeName, queryParameters: {'id': id}).toString();
    // }
    return routeName;
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool forceRootNavigator = false,
  }) {
    /// Override the routeName with new Uri format, support Web param
    routeName = generateUri(arguments, routeName);

    if (forceRootNavigator) {
      return _rootNavigator.pushNamed<T?>(
        routeName,
        arguments: arguments,
      );
    }

    return _navigator.pushNamed<T?>(
      routeName,
      arguments: arguments,
    );
  }

  static Future pushReplacementNamed(
    String routeName, {
    Object? arguments,
    bool forceRootNavigator = false,
  }) {
    if (forceRootNavigator) {
      return _rootNavigator.pushReplacementNamed(routeName);
    }
    return _navigator.pushReplacementNamed(routeName);
  }

  static Future pushNamedAndRemoveUntil(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
    bool forceRootNavigator = false,
  }) {
    if (forceRootNavigator) {
      return _rootNavigator.pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
    }
    return _navigator.pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  static Future<dynamic> push(Route<dynamic> route, {bool forceRootNavigator = false}) {
    if (forceRootNavigator) {
      return _rootNavigator.push(route);
    }
    return _navigator.push(route);
  }
}
