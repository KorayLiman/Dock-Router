import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/delegate/dock_router_delegate.dart';
import 'package:dock_router/src/navigator/dock_navigator.dart';
import 'package:dock_router/src/router/dock_router_inherited.dart';
import 'package:flutter/material.dart';

mixin RoutingOperationMixin {
  Future<T?> push<T extends Object>(String name, {Object? arguments});

  Future<T?> pushReplacement<T extends Object>(String name, {Object? arguments});

  Future<T?> pushReplacementAll<T extends Object>(String name, {Object? arguments});

  Future<T?> pushAll<T extends Object>(List<String> names, {Object? arguments});

  Future<void> pushAndRemoveUntil(String name, {Object? arguments});

  Future<bool> pop<T extends Object>([T? result]);

  Future<void> popUntil(String name);

  Future<void> popBelow();

  Future<void> removeWhere(bool Function(DockRoute route) predicate);
}

abstract class DockRouterBase with RoutingOperationMixin {
  List<DockPage<Object>> get history;

  DockRoute get currentRoute;

  DockRoute? get previousRoute;

  Object? get arguments;

  static const routerLoggerName = 'DOCK ROUTER';

  List<RouteConfigurationBase> Function() get routes;
}

class DockRouter extends DockRouterBase implements RouterConfig<Object> {
  DockRouter({required this.routes, BackButtonDispatcher? androidBackButtonDispatcher}) : backButtonDispatcher = androidBackButtonDispatcher ?? RootBackButtonDispatcher() {
    routerDelegate = DockRouterDelegate(this);
  }

  @override
  final List<RouteConfigurationBase> Function() routes;

  @override
  late BackButtonDispatcher backButtonDispatcher;

  @override
  RouteInformationParser<Object>? get routeInformationParser => null;

  @override
  RouteInformationProvider? get routeInformationProvider => null;

  @override
  late final DockRouterDelegate<Object> routerDelegate;

  static DockRouterBase of(BuildContext context, {bool rootRouter = false}) {
    if (!rootRouter) {
      final inheritedRouter = context.dependOnInheritedWidgetOfExactType<InheritedDockRouter>();
      assert(inheritedRouter != null, 'No DockRouter found in Widget Tree for given context');
      return inheritedRouter!.router;
    } else {
      final rootNavigatorState = context.findRootAncestorStateOfType<DockNavigatorState>();
      assert(rootNavigatorState != null, 'No DockNavigator found in Widget Tree for given context');
      return rootNavigatorState!.router;
    }
  }

  static DockRouterBase? maybeOf(BuildContext context) {
    final inheritedRouter = context.dependOnInheritedWidgetOfExactType<InheritedDockRouter>();
    if (inheritedRouter == null) return null;
    return inheritedRouter.router;
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
  Future<bool> pop<T extends Object>([T? result]) {
    return routerDelegate.pop<T>(result);
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
  List<DockPage<Object>> get history => List.unmodifiable(routerDelegate.history);

  @override
  DockRoute get currentRoute => history.last.route;

  @override
  DockRoute? get previousRoute => history.length <= 1 ? null : history[history.length - 2].route;

  @override
  Object? get arguments => currentRoute.page.arguments;

  static bool isLoggingEnabled = true;
}
