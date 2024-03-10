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
  State<TabsRouterWidget> createState() => TabsRouterWidgetState();
}

class TabsRouterWidgetState extends State<TabsRouterWidget> {
  late final DockRouter _router;

  @override
  void initState() {
    final current = widget.parentRouter.routes().firstWhere(
          (element) => element.name == widget.parentRouter.currentRoute.name,
        );
    _router = DockRouter.tab(
      routes: () => current.children[widget.index].children,
      tabIndex: widget.index,
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
