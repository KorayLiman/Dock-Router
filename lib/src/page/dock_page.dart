import 'dart:async';

import 'package:dock_router/src/route/dock_routes.dart';
import 'package:flutter/material.dart';

typedef ExitCallback = FutureOr<bool> Function(BuildContext context);

abstract class DockPage<T> extends Page<T> {
  DockPage({
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    this.onExit,
  });

  final _popCompleter = Completer<T?>();

  Future<T?> get waitForPop => _popCompleter.future;

  void completePop(T? result) {
    assert(!_popCompleter.isCompleted, '''
  Pop Completer is completed already
  This is a bug, please report it to @KorayLiman)''');
    _popCompleter.complete(result);
  }

  bool get allowSnapshotting;

  bool get barrierDismissible;

  bool get fullscreenDialog;
  bool get maintainState;

  final FutureOr<bool> Function(BuildContext)? onExit;
}

class DockCupertinoPage<T> extends DockPage<T> {
  /// Creates a cupertino page.
  DockCupertinoPage({
    required this.child,
    // this.initial = false,
    super.onExit,
    this.maintainState = true,
    this.title,
    this.fullscreenDialog = false,
    this.allowSnapshotting = true,
    this.barrierDismissible = false,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(key: ValueKey(name));

  final Widget child;

  final String? title;

  @override
  final bool maintainState;

  @override
  DockCupertinoRoute<T> createRoute(BuildContext context) {
    return DockCupertinoRoute(
      page: this,
      allowSnapshotting: allowSnapshotting,
      barrierDismissible: barrierDismissible,
      fullscreenDialog: fullscreenDialog,
    );
  }

  @override
  final bool allowSnapshotting;

  @override
  final bool barrierDismissible;

  @override
  final bool fullscreenDialog;
}

class DockMaterialPage<T> extends DockPage<T> {
  /// Creates a material page.
  DockMaterialPage({
    required this.child,
    super.onExit,
    // this.initial = false,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.allowSnapshotting = true,
    this.barrierDismissible = false,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(key: ValueKey(name));

  final Widget child;

  @override
  final bool maintainState;

  @override
  final bool allowSnapshotting;

  @override
  final bool barrierDismissible;

  @override
  final bool fullscreenDialog;

  @override
  DockMaterialRoute<T> createRoute(BuildContext context) {
    return DockMaterialRoute(
      page: this,
      allowSnapshotting: allowSnapshotting,
      barrierDismissible: barrierDismissible,
      fullscreenDialog: fullscreenDialog,
    );
  }
}