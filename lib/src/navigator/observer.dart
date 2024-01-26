import 'dart:developer';

import 'package:dock_router/dock_router.dart';
import 'package:flutter/cupertino.dart';

class DockNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (DockRouter.isLoggingEnabled) {
      final routeInfo = route.settings.name ?? route;
      log('Pushed $routeInfo', name: DockRouterBase.routerLoggerName);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (DockRouter.isLoggingEnabled) {
      final routeInfo = route.settings.name ?? route;
      log('Popped $routeInfo', name: DockRouterBase.routerLoggerName);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (DockRouter.isLoggingEnabled) {
      final routeInfo = route.settings.name ?? route;
      log('Removed $routeInfo', name: DockRouterBase.routerLoggerName);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (DockRouter.isLoggingEnabled) {
      final oldRouteInfo = oldRoute?.settings.name ?? oldRoute;
      final newRouteInfo = newRoute?.settings.name ?? newRoute;
      log('Replaced $oldRouteInfo with $newRouteInfo', name: DockRouterBase.routerLoggerName);
    }
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (DockRouter.isLoggingEnabled) {
      final routeInfo = route.settings.name ?? route;
      log('Started swipe back gesture on $routeInfo', name: DockRouterBase.routerLoggerName);
    }
  }

  @override
  void didStopUserGesture() {
    if (DockRouter.isLoggingEnabled) {
      log('Stopped swipe back gesture', name: DockRouterBase.routerLoggerName);
    }
  }
}
