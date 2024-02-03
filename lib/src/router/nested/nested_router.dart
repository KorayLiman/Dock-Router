import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class NestedRouter extends StatefulWidget {
  const NestedRouter({
    super.key,
  }) : tabIndex = null;

  const NestedRouter.tab({required this.tabIndex, super.key});

  final int? tabIndex;

  @override
  State<NestedRouter> createState() => NestedRouterState();
}

class NestedRouterState extends State<NestedRouter> {
  late final DockRouter _nestedRouter;

  DockRouter get router => _nestedRouter;

  @override
  void initState() {
    final parent = DockRouter.of(context);

    _nestedRouter = widget.tabIndex != null
        ? DockRouter.tab(
            tabIndex: widget.tabIndex!,
            routes: () => parent.routes().firstWhere((element) => element.name == parent.currentRoute.name).children,
            backButtonDispatcher: parent.backButtonDispatcher.createChildBackButtonDispatcher(),
          )
        : DockRouter.nested(
            routes: () => parent.routes().firstWhere((element) => element.name == parent.currentRoute.name).children,
            backButtonDispatcher: parent.backButtonDispatcher.createChildBackButtonDispatcher(),
          );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Router.withConfig(config: router);
  }
}
