import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/delegate/dock_router_delegate.dart';
import 'package:dock_router/src/router/dock_router_inherited.dart';
import 'package:flutter/material.dart';

abstract interface class RoutingOperation {
  Future<T?> push<T extends Object>(String name, {Object? arguments});

  Future<T?> pushReplacement<T extends Object>(String name, {Object? arguments});

  Future<T?> pushReplacementAll<T extends Object>(String name, {Object? arguments});

  void pop<T extends Object>([T? result]);

  Future<void> popUntil(String name);

  Future<void> popBelow();
}

abstract class DockRouterBase {
  List<DockPage<Object>> get history;

  DockRoute get currentRoute;
}

class DockRouter extends DockRouterBase implements RouterConfig<Object>, RoutingOperation {
  DockRouter({required List<DockRouteConfig> Function() routes}) : backButtonDispatcher = RootBackButtonDispatcher() {
    routerDelegate = DockRouterDelegate(this, routes);
  }

  @override
  final BackButtonDispatcher backButtonDispatcher;

  @override
  RouteInformationParser<Object>? get routeInformationParser => null;

  @override
  RouteInformationProvider? get routeInformationProvider => null;

  @override
  late final DockRouterDelegate<Object> routerDelegate;

  @override
  List<DockPage<Object>> get history => List.unmodifiable(routerDelegate.history);

  @override
  DockRoute get currentRoute => history.last.route;

  static DockRouter of(BuildContext context) {
    final inheritedRouter = context.dependOnInheritedWidgetOfExactType<InheritedDockRouter>();
    assert(inheritedRouter != null, 'No DockRouter found in Widget Tree for given context');
    return inheritedRouter!.router;
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
  void pop<T extends Object>([T? result]) {
    routerDelegate.pop<T>(result);
  }

  @override
  Future<void> popUntil(String name) {
    return routerDelegate.popUntil(name);
  }

  @override
  Future<void> popBelow() {
    return routerDelegate.popBelow();
  }
}
