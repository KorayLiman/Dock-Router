import 'dart:developer';

import 'package:dock_router/dock_router.dart';
import 'package:flutter/cupertino.dart';

class DockNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeInfo = route.settings.name ?? route;
    log('Pushed $routeInfo', name: '$_logName/$_routerRole');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeInfo = route.settings.name ?? route;
    log('Popped $routeInfo', name: '$_logName/$_routerRole');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeInfo = route.settings.name ?? route;
    log('Removed $routeInfo', name: '$_logName/$_routerRole');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final oldRouteInfo = oldRoute?.settings.name ?? oldRoute;
    final newRouteInfo = newRoute?.settings.name ?? newRoute;
    log('Replaced $oldRouteInfo with $newRouteInfo', name: _logName);
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeInfo = route.settings.name ?? route;
    log('Started swipe back gesture on $routeInfo', name: '$_logName/$_routerRole');
  }

  @override
  void didStopUserGesture() {
    log('Stopped swipe back gesture', name: '$_logName/$_routerRole');
  }

  final _logName = DockRouterBase.logName;

  String? get _routerRole {
    final context = navigator?.context;
    if (context == null || !context.mounted) return null;

    return switch (context.router.isRoot) {
      true => 'ROOT',
      false => 'NESTED',
    };
  }
}
