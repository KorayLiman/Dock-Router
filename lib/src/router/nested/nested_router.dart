import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class TabsRouterWidget extends StatefulWidget {
  const TabsRouterWidget({
    required this.index,
    required this.parentRouter,
    this.navigatorObservers,
    super.key,
  });

  final int index;
  final DockRouter parentRouter;
  final List<NavigatorObserver>? navigatorObservers;

  @override
  State<TabsRouterWidget> createState() => _TabsRouterWidgetState();
}

class _TabsRouterWidgetState extends State<TabsRouterWidget> {
  late final DockRouter _router;

  @override
  void initState() {
    final current = widget.parentRouter.routes().firstWhere(
          (element) => element.name == widget.parentRouter.currentRoute.name,
        );
    _router = DockRouter.nested(
      routes: () => current.children[widget.index].children,
      initial: current.children[widget.index],
      backButtonDispatcher: widget.parentRouter.backButtonDispatcher.createChildBackButtonDispatcher(),
      navigatorObservers: widget.navigatorObservers,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Router.withConfig(config: _router);
  }
}

class NestedRouterWidget extends StatefulWidget {
  const NestedRouterWidget({
    super.key,
    this.navigatorObservers,
  });

  final List<NavigatorObserver>? navigatorObservers;

  @override
  State<NestedRouterWidget> createState() => NestedRouterWidgetState();
}

class NestedRouterWidgetState extends State<NestedRouterWidget> {
  late final DockRouter _router;

  @override
  void initState() {
    final parent = context.router;

    _router = DockRouter.nested(
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
