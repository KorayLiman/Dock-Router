import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/delegate/dock_router_delegate.dart';
import 'package:flutter/material.dart';

class NestedRouter extends StatefulWidget {
  const NestedRouter({super.key});

  @override
  State<NestedRouter> createState() => _NestedRouterState();
}

class _NestedRouterState extends State<NestedRouter> {
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
}
