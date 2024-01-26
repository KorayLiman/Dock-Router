import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/navigator/observer.dart';
import 'package:dock_router/src/router/dock_router_inherited.dart';
import 'package:flutter/material.dart';

class DockNavigator extends StatefulWidget {
  const DockNavigator({
    required DockRouter router,
    required GlobalKey<DockNavigatorState> key,
    required this.pages,
    required this.navigatorKey,
    required this.onPopPage,
  })  : _router = router,
        super(key: key);

  final DockRouter _router;
  final List<DockPage<Object>> pages;
  final GlobalKey<NavigatorState> navigatorKey;
  final bool Function(Route<dynamic> route, dynamic result) onPopPage;

  @override
  State<DockNavigator> createState() => DockNavigatorState();
}

class DockNavigatorState extends State<DockNavigator> {
  @override
  void initState() {
    _configureBackButtonDispatcher();
    super.initState();
  }

  void rebuild() {
    if (mounted) setState(() {});
  }

  void _configureBackButtonDispatcher() {
    if (widget._router.backButtonDispatcher is RootBackButtonDispatcher) return;
    final parentRouter = Router.of(context);
    widget._router.backButtonDispatcher = parentRouter.backButtonDispatcher!.createChildBackButtonDispatcher();
  }

  void _takeBackButtonPriority() {
    widget._router.backButtonDispatcher.takePriority();
  }

  DockRouter get router => widget._router;

  @override
  Widget build(BuildContext context) {
    _takeBackButtonPriority();
    return InheritedDockRouter(
      router: widget._router,
      child: Navigator(
        key: widget.navigatorKey,
        pages: widget.pages,
        onPopPage: widget.onPopPage,
        observers: [
          DockNavigatorObserver(),
        ],
      ),
    );
  }
}
