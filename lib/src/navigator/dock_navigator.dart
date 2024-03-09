import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class DockNavigator extends StatefulWidget {
  const DockNavigator({
    required DockRouterBase router,
    required GlobalKey<DockNavigatorState> key,
    required this.navigatorKey,
    required this.onPopPage,
  })  : _router = router,
        super(key: key);

  final DockRouterBase _router;
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
      pages: router.history,
      onPopPage: widget.onPopPage,
      observers: router.navigatorObservers ?? const <NavigatorObserver>[],
    );

    router.backButtonDispatcher.takePriority();
    if (!router.isRoot && router.history.length != 1) {
      return PopScope(
        canPop: false,
        child: navigator,
      );
    }

    return navigator;
  }
}
