import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/delegate/dock_router_delegate.dart';
import 'package:flutter/material.dart';

abstract class DockRouterBase implements RouterConfig<Object> {
  Future<T?> push<T extends Object>(String name, {Object? arguments});
  void pop<T extends Object>([T? result]);
}

class DockRouter extends DockRouterBase {
  DockRouter({required List<DockRouteConfig<Object>> Function() routes}) : backButtonDispatcher = RootBackButtonDispatcher() {
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
  Future<T?> push<T extends Object>(String name, {Object? arguments}) async {
    return routerDelegate.push<T>(name, arguments: arguments);
  }

  @override
  void pop<T extends Object>([T? result]) {
    routerDelegate.pop<T>(result);
  }
}
