import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/navigator/observer.dart';
import 'package:flutter/material.dart';

class DockNavigator extends StatefulWidget {
  const DockNavigator({
    required DockRouterBase router,
    required GlobalKey<DockNavigatorState> key,
    required this.pages,
    required this.navigatorKey,
    required this.onPopPage,
  })  : _router = router,
        super(key: key);

  final DockRouterBase _router;
  final List<DockPage<Object>> pages;
  final GlobalKey<NavigatorState> navigatorKey;
  final bool Function(Route<dynamic> route, dynamic result) onPopPage;

  @override
  State<DockNavigator> createState() => DockNavigatorState();
}

class DockNavigatorState extends State<DockNavigator> {
  void rebuild() {
    if (mounted) setState(() {});
  }

  DockRouterBase get router => widget._router;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator(
      key: widget.navigatorKey,
      pages: widget.pages,
      onPopPage: widget.onPopPage,
      observers: [
        DockNavigatorObserver(),
      ],
    );

    final tabsBuilder = TabsBuilder.maybeOf(context);
    if (tabsBuilder == null) {
      router.backButtonDispatcher.takePriority();
      if (!router.isRoot && router.history.length != 1) {
        return PopScope(
          canPop: false,
          child: navigator,
        );
      }
    } else {
      if (tabsBuilder.activeTabIndex == router.history.first.configuration.tabIndex) {
        if (router.history.length == 1) {
          (router.backButtonDispatcher as ChildBackButtonDispatcher).parent.takePriority();
        } else {
          router.backButtonDispatcher.takePriority();
        }
        if (!router.isRoot && router.history.length != 1) {
          return PopScope(
            canPop: false,
            child: navigator,
          );
        }
      }
    }
    return navigator;
  }
}
