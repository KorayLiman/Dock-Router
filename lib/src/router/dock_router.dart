import 'dart:collection';

import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

abstract interface class RoutingUtilities {
  Future<T?> push<T extends Object>(String name, {Object? arguments});

  Future<T?> pushReplacement<T extends Object>(String name, {Object? arguments});

  Future<T?> pushReplacementAll<T extends Object>(String name, {Object? arguments});

  Future<T?> pushAll<T extends Object>(List<String> names, {Object? arguments});

  Future<void> pushAndRemoveUntil(String name, {Object? arguments});

  Future<bool> pop<T extends Object>({T? result, bool ignoreOnExit = false});

  Future<void> popUntil(String name);

  Future<void> popBelow();

  Future<void> removeWhere(bool Function(DockRoute route) predicate);
}

abstract class DockRouterBase implements RoutingUtilities {
  UnmodifiableListView<DockPage<Object>> get history;

  DockRoute get currentRoute;

  DockRoute? get previousRoute;

  Object? get arguments;

  static const logName = 'DOCK ROUTER';

  BackButtonDispatcher get backButtonDispatcher;

  List<RouteConfigurationBase> Function() get routes;

  bool get isRoot;

  GlobalKey<NavigatorState> get navigatorKey;

  List<NavigatorObserver>? get navigatorObservers;
}

class DockRouter extends DockRouterBase implements RouterConfig<Object> {
  DockRouter({
    required this.routes,
    this.navigatorObservers,
    this.androidOnExitApplication,
  }) : backButtonDispatcher = RootBackButtonDispatcher() {
    routerDelegate = DockRouterDelegate(this);
  }

  DockRouter.nested({
    required this.routes,
    required this.backButtonDispatcher,
    this.navigatorObservers,
  }) : androidOnExitApplication = null {
    routerDelegate = DockRouterDelegate.nested(this);
  }

  DockRouter.tab({
    required this.routes,
    required int tabIndex,
    required this.backButtonDispatcher,
    this.navigatorObservers,
  }) : androidOnExitApplication = null {
    routerDelegate = DockRouterDelegate.tab(this, tabIndex);
  }

  final ExitCallback? androidOnExitApplication;

  @override
  final List<RouteConfigurationBase> Function() routes;

  @override
  final BackButtonDispatcher backButtonDispatcher;

  @override
  RouteInformationParser<Object>? routeInformationParser;

  @override
  RouteInformationProvider? routeInformationProvider;

  @override
  late final DockRouterDelegate routerDelegate;

  static DockRouterBase of(BuildContext context, {bool rootRouter = false}) {
    if (!rootRouter) {
      final dockNavigatorState = context.findAncestorStateOfType<DockNavigatorState>();
      assert(dockNavigatorState != null, 'No DockRouter found in Widget Tree for given context');
      return dockNavigatorState!.router;
    } else {
      final rootNavigatorState = context.findRootAncestorStateOfType<DockNavigatorState>();
      assert(rootNavigatorState != null, 'No DockRouter found in Widget Tree for given context');
      return rootNavigatorState!.router;
    }
  }

  static DockRouterBase parentOf(BuildContext context) {
    final currentRouterContext = context.findAncestorStateOfType<DockNavigatorState>()?.context;
    assert(currentRouterContext != null, 'No DockRouter found in Widget Tree for given context');
    final parentRouter = currentRouterContext!.findAncestorStateOfType<DockNavigatorState>()?.router;
    assert(parentRouter != null, 'No Parent DockRouter found in Widget Tree for given context');
    return parentRouter!;
  }

  static DockRouterBase? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<DockNavigatorState>()?.router;
  }

  @override
  Future<T?> push<T extends Object>(String name, {Object? arguments}) async {
    return routerDelegate.push<T>(name, arguments: arguments);
  }

  @override
  Future<T?> pushReplacement<T extends Object>(String name, {Object? arguments}) {
    return routerDelegate.pushReplacement<T>(name, arguments: arguments);
  }

  @override
  Future<T?> pushReplacementAll<T extends Object>(String name, {Object? arguments}) {
    return routerDelegate.pushReplacementAll<T>(name, arguments: arguments);
  }

  @override
  Future<T?> pushAll<T extends Object>(List<String> names, {Object? arguments}) {
    return routerDelegate.pushAll<T>(names, arguments: arguments);
  }

  @override
  Future<void> pushAndRemoveUntil(String name, {Object? arguments}) {
    return routerDelegate.pushAndRemoveUntil(name, arguments: arguments);
  }

  @override
  Future<bool> pop<T extends Object>({T? result, bool ignoreOnExit = false}) {
    return routerDelegate.pop<T>(result: result, ignoreOnExit: ignoreOnExit);
  }

  @override
  Future<void> popUntil(String name) {
    return routerDelegate.popUntil(name);
  }

  @override
  Future<void> popBelow() {
    return routerDelegate.popBelow();
  }

  @override
  Future<void> removeWhere(bool Function(DockRoute route) predicate) {
    return routerDelegate.removeWhere(predicate);
  }

  //////////////////////
  ////
  //////////////////////
  @override
  UnmodifiableListView<DockPage<Object>> get history => routerDelegate.history;

  @override
  DockRoute get currentRoute => history.last.route;

  @override
  DockRoute? get previousRoute => history.length <= 1 ? null : history[history.length - 2].route;

  @override
  Object? get arguments => currentRoute.page.arguments;

  @override
  bool get isRoot => backButtonDispatcher is RootBackButtonDispatcher;

  @override
  GlobalKey<NavigatorState> get navigatorKey => routerDelegate.navigatorKey;

  @override
  final List<NavigatorObserver>? navigatorObservers;
}
