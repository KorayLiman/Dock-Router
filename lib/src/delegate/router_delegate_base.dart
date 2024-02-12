import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

abstract class RouterDelegateBase extends RouterDelegate<RouteConfigurationBase> with ChangeNotifier, PopNavigatorRouterDelegateMixin implements RoutingUtilities {
  List<DockPage<Object>> get history;

  @override
  GlobalKey<NavigatorState> get navigatorKey;
}
