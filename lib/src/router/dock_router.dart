import 'package:dock_router/src/delegate/dock_router_delegate.dart';
import 'package:dock_router/src/page/dock_page.dart';
import 'package:flutter/material.dart';

abstract class DockRouterBase implements RouterConfig<Object> {
  Future<T?> push<T extends Object?>(String name, {Object? arguments});
}

class DockRouter extends DockRouterBase {
  DockRouter({required List<DockPageBase<Object>> pages}) : backButtonDispatcher = RootBackButtonDispatcher() {
    routerDelegate = DockRouterDelegate(this, pages: pages);
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
  Future<T?> push<T extends Object?>(String name, {Object? arguments}) async {
    return routerDelegate.push<T>(name, arguments: arguments);
  }
}
