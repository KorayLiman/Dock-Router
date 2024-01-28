import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/delegate/dock_router_delegate.dart';
import 'package:flutter/material.dart';

class NestedRouter extends StatefulWidget {
  const NestedRouter({super.key});

  @override
  State<NestedRouter> createState() => _NestedRouterState();
}

class _NestedRouterState extends State<NestedRouter> implements DockRouterBase {
  late final DockRouter _router;

  @override
  void initState() {
    _router = DockRouter(
      routes: DockRouter.of(context, rootRouter: true).routes,
      androidBackButtonDispatcher: Router.of(context).backButtonDispatcher!.createChildBackButtonDispatcher(),
    );
    super.initState();
  }

  void _takeBackButtonPriority() {
    _router.backButtonDispatcher.takePriority();
  }

  @override
  Widget build(BuildContext context) {
    _takeBackButtonPriority();
    return Router(
      routerDelegate: DockRouterDelegate<Object>(_router),
      backButtonDispatcher: _router.backButtonDispatcher,
    );
  }

  @override
  Object? get arguments => history.last.arguments;

  @override
  DockRoute get currentRoute => history.last.route;

  @override
  // TODO: implement history
  List<DockPage<Object>> get history => throw UnimplementedError();

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
  // TODO: implement previousRoute
  DockRoute? get previousRoute => history.length <= 1 ? null : history[history.length - 2].route;

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
  // TODO: implement routes
  List<RouteConfigurationBase> Function() get routes => DockRouter.of(context, rootRouter: true).routes;
}
