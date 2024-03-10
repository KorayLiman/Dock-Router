import 'dart:io';

import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class DockNavigator extends StatefulWidget {
  const DockNavigator({
    required DockRouterBase router,
    required GlobalKey<DockNavigatorState> key,
    required this.navigatorKey,
    required this.onPopPage,
    int? navIndex,
  })  : _router = router,
        _navIndex = navIndex,
        super(key: key);

  final int? _navIndex;
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
    if (widget._navIndex != null) {
      if (widget._navIndex == TabsBuilder.of(context).activeIndex) {
        if (router.history.length > 1) {
          router.backButtonDispatcher.takePriority();
          return PopScope(
            canPop: false,
            child: navigator,
          );
        } else if (Platform.isAndroid && widget._navIndex != 0) {
          DockRouter.of(context).backButtonDispatcher.takePriority();
          return PopScope(
            canPop: false,
            onPopInvoked: (result) {
              TabsBuilder.of(context).setActiveIndex(widget._navIndex! - 1);
            },
            child: navigator,
          );
        } else {
          DockRouter.of(context).backButtonDispatcher.takePriority();
        }
      }
    } else {
      router.backButtonDispatcher.takePriority();
      if (!router.isRoot && router.history.length != 1) {
        return PopScope(
          canPop: false,
          child: navigator,
        );
      }
    }

    return navigator;
  }
}
