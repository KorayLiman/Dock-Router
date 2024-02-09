import 'dart:async';

import 'package:dock_router/dock_router.dart';
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

  String get name;
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
  Widget buildContent(BuildContext context) => page.builder(context);

  @override
  bool get maintainState => page.maintainState;

  @override
  bool get fullscreenDialog => page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${page.name})';

  @override
  final DockMaterialPage<T> page;

  @override
  String get name => page.name!;
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
  Widget buildContent(BuildContext context) => PopScope(
        canPop: page.onExit == null,
        onPopInvoked: (result) async {
          final result = await page.onExit?.call(context);
          if (result ?? false) {
            if (context.mounted) {
              unawaited(DockRouter.of(context).pop(force: true));
            }
          }
        },
        child: page.builder(context),
      );

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

  @override
  String get name => page.name!;
}
