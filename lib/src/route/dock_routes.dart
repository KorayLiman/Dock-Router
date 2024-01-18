import 'dart:async';
import 'dart:io';

import 'package:dock_router/src/page/dock_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DockRoute<T> {
  DockRoute({
    required this.name,
    required Widget child,
    this.initial = false,
    this.onExit,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.barrierDismissible = false,
  }) : assert(Platform.isAndroid || Platform.isIOS, 'DockRouter only supports Android and iOS') {
    page = Platform.isAndroid
        ? DockMaterialPage<T>(
            name: name,
            child: child,
            allowSnapshotting: allowSnapshotting,
            fullscreenDialog: fullscreenDialog,
            barrierDismissible: barrierDismissible,
            onExit: onExit,
          )
        : DockCupertinoPage<T>(
            name: name,
            child: child,
            allowSnapshotting: allowSnapshotting,
            fullscreenDialog: fullscreenDialog,
            barrierDismissible: barrierDismissible,
            onExit: onExit,
          );
  }

  final String name;

  final bool initial;
  final bool fullscreenDialog;
  final bool allowSnapshotting;
  final bool barrierDismissible;

  late final DockPage<T> page;
  final FutureOr<bool> Function(BuildContext)? onExit;
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
