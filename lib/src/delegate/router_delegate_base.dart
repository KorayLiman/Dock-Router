import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

abstract class RouterDelegateBase extends RouterDelegate<RouteConfigurationBase> with ChangeNotifier, RoutingOperationMixin, PopNavigatorRouterDelegateMixin {
  List<DockPage<Object>> get history;
}
