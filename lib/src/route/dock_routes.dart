import 'package:dock_router/src/page/dock_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract interface class DockRoute {
  static DockRoute of(BuildContext context) {
    final route = ModalRoute.of(context);
    assert(route != null, 'No route found for context');
    assert(route is DockRoute, 'Route is not a DockRoute');
    return route! as DockRoute;
  }

  DockPage<dynamic> get page;
}

class DockMaterialRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> implements DockRoute {
  DockMaterialRoute({
    required this.page,
    super.allowSnapshotting,
    super.barrierDismissible,
    super.fullscreenDialog,
  }) : super(settings: page) {
    assert(opaque, 'DockMaterialRoute must be opaque');
  }

  @override
  Widget buildContent(BuildContext context) => page.child;

  @override
  bool get maintainState => page.maintainState;

  @override
  bool get fullscreenDialog => page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${page.name})';

  @override
  final DockMaterialPage<T> page;
}

class DockCupertinoRoute<T> extends PageRoute<T> with CupertinoRouteTransitionMixin<T> implements DockRoute {
  DockCupertinoRoute({
    required this.page,
    super.allowSnapshotting,
    super.barrierDismissible,
    super.fullscreenDialog,
  }) : super(settings: page) {
    assert(opaque, 'DockCupertinoRoute must be opaque');
  }

  @override
  Widget buildContent(BuildContext context) => page.child;

  @override
  String? get title => page.title;

  @override
  bool get maintainState => page.maintainState;

  @override
  bool get fullscreenDialog => page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${page.name})';

  @override
  final DockCupertinoPage<T> page;
}
