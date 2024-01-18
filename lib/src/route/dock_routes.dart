import 'dart:async';
import 'dart:io';

import 'package:dock_router/src/page/dock_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DockRoute<T> {
  DockRoute({
    required this.name,
    required this.child,
    this.initial = false,
    this.onExit,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.barrierDismissible = false,
    this.maintainState = true,
    this.restorationId,
  }) : assert(Platform.isAndroid || Platform.isIOS, 'DockRouter only supports Android and iOS');

  final String name;
  final Widget child;
  final bool initial;
  final bool fullscreenDialog;
  final bool allowSnapshotting;
  final bool barrierDismissible;
  final bool maintainState;
  final String? restorationId;

  final FutureOr<bool> Function(BuildContext)? onExit;

  DockPage<T> createPage([Object? arguments]) {
    return Platform.isAndroid
        ? DockMaterialPage<T>(
            name: name,
            child: child,
            allowSnapshotting: allowSnapshotting,
            fullscreenDialog: fullscreenDialog,
            barrierDismissible: barrierDismissible,
            onExit: onExit,
            restorationId: restorationId,
            maintainState: maintainState,
            arguments: arguments,
          )
        : DockCupertinoPage<T>(
            name: name,
            child: child,
            allowSnapshotting: allowSnapshotting,
            fullscreenDialog: fullscreenDialog,
            barrierDismissible: barrierDismissible,
            onExit: onExit,
            restorationId: restorationId,
            maintainState: maintainState,
            arguments: arguments,
          );
  }
}

class DockMaterialRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
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

  final DockMaterialPage<T> page;
}

class DockCupertinoRoute<T> extends PageRoute<T> with CupertinoRouteTransitionMixin<T> {
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

  final DockCupertinoPage<T> page;
}
