import 'dart:developer';

import 'package:dock_router/dock_router.dart';
import 'package:flutter/cupertino.dart';

class DockNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (DockRouter.isLoggingEnabled) log('Pushed ${route.settings.name}', name: 'DOCK ROUTER');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (DockRouter.isLoggingEnabled) log('Popped ${route.settings.name}', name: 'DOCK ROUTER');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (DockRouter.isLoggingEnabled) log('Removed ${route.settings.name}', name: 'DOCK ROUTER');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (DockRouter.isLoggingEnabled) log('Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}', name: 'DOCK ROUTER');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (DockRouter.isLoggingEnabled) log('Started swipe back gesture on ${route.settings.name}', name: 'DOCK ROUTER');
  }

  @override
  void didStopUserGesture() {
    if (DockRouter.isLoggingEnabled) log('Stopped swipe back gesture', name: 'DOCK ROUTER');
  }
}
