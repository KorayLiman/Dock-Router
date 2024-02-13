import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class NestedRouter extends StatefulWidget {
  const NestedRouter({
    super.key,
    this.navigatorObservers,
  }) : tabIndex = null;

  const NestedRouter.tab({required this.tabIndex, super.key, this.navigatorObservers});

  final List<NavigatorObserver>? navigatorObservers;
  final int? tabIndex;

  @override
  State<NestedRouter> createState() => NestedRouterState();
}

class NestedRouterState extends State<NestedRouter> {
  late final DockRouter _router;

  @override
  void initState() {
    final parent = context.router;

    _router = widget.tabIndex != null
        ? DockRouter.tab(
            tabIndex: widget.tabIndex!,
            routes: () => parent.routes().firstWhere((element) => element.name == parent.currentRoute.name).children,
            backButtonDispatcher: parent.backButtonDispatcher.createChildBackButtonDispatcher(),
            navigatorObservers: widget.navigatorObservers,
          )
        : DockRouter.nested(
            routes: () => parent.routes().firstWhere((element) => element.name == parent.currentRoute.name).children,
            backButtonDispatcher: parent.backButtonDispatcher.createChildBackButtonDispatcher(),
            navigatorObservers: widget.navigatorObservers,
          );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Router.withConfig(config: _router);
  }
}
