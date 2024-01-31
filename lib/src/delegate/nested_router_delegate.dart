import 'package:dock_router/src/delegate/dock_router_delegate.dart';
import 'package:dock_router/src/route/configuration.dart';
import 'package:dock_router/src/route/dock_routes.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';

class NestedRouterDelegate<R> extends RootRouterDelegate<RouteConfigurationBase> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<bool> pop<T extends Object>([T? result]) {
    // TODO: implement pop
    throw UnimplementedError();
  }

  @override
  Future<void> popBelow() {
    // TODO: implement popBelow
    throw UnimplementedError();
  }

  @override
  Future<void> popUntil(String name) {
    // TODO: implement popUntil
    throw UnimplementedError();
  }

  @override
  Future<T?> push<T extends Object>(String name, {Object? arguments}) {
    // TODO: implement push
    throw UnimplementedError();
  }

  @override
  Future<T?> pushAll<T extends Object>(List<String> names, {Object? arguments}) {
    // TODO: implement pushAll
    throw UnimplementedError();
  }

  @override
  Future<void> pushAndRemoveUntil(String name, {Object? arguments}) {
    // TODO: implement pushAndRemoveUntil
    throw UnimplementedError();
  }

  @override
  Future<T?> pushReplacement<T extends Object>(String name, {Object? arguments}) {
    // TODO: implement pushReplacement
    throw UnimplementedError();
  }

  @override
  Future<T?> pushReplacementAll<T extends Object>(String name, {Object? arguments}) {
    // TODO: implement pushReplacementAll
    throw UnimplementedError();
  }

  @override
  Future<void> removeWhere(bool Function(DockRoute route) predicate) {
    // TODO: implement removeWhere
    throw UnimplementedError();
  }

  @override
  Future<void> setNewRoutePath(RouteConfigurationBase configuration) => throw UnimplementedError();
}
