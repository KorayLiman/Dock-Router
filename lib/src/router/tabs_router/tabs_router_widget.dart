import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/router/dock_router_inherited.dart';
import 'package:dock_router/src/router/tabs_router/tabs_router.dart';
import 'package:flutter/material.dart';

class TabsRouterWidget extends StatefulWidget {
  const TabsRouterWidget({super.key});

  @override
  State<TabsRouterWidget> createState() => _TabsRouterWidgetState();
}

class _TabsRouterWidgetState extends State<TabsRouterWidget> {
  late final TabsRouter _tabsRouter;

  @override
  void initState() {
    _tabsRouter = TabsRouter(
      routes: () =>DockRouter.of(context).currentRoute.,
      dispatcher: _getBackButtonDispatcher(context),
    );
    super.initState();
  }

  BackButtonDispatcher _getBackButtonDispatcher(BuildContext context) {
    return Router
        .of(context)
        .backButtonDispatcher!
        .createChildBackButtonDispatcher()
    ;
  }

  void _setBackButtonDispatcherPriority(BuildContext context) {
    _tabsRouter.backButtonDispatcher.takePriority();
  }

  @override
  Widget build(BuildContext context) {
    _setBackButtonDispatcherPriority(context);
    return InheritedDockRouter(
      router: _tabsRouter,
      child: Router(
        routerDelegate: _tabsRouter.routerDelegate,
        backButtonDispatcher: _tabsRouter.backButtonDispatcher,
      ),
    );
  }
}
