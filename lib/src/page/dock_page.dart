import 'dart:async';

import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

typedef ExitCallback = FutureOr<bool> Function(BuildContext context)?;

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

  final ExitCallback onExit;

  DockRoute get route;

  WidgetBuilder get builder;

  RouteConfigurationBase get configuration;
}

class DockCupertinoPage<T> extends DockPage<T> {
  /// Creates a cupertino page.
  DockCupertinoPage({
    required this.builder,
    required super.key,
    required this.configuration,
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
  });

  @override
  final WidgetBuilder builder;

  final String? title;

  @override
  final RouteConfigurationBase configuration;

  @override
  final bool maintainState;

  @override
  DockCupertinoRoute<T> createRoute(BuildContext context) {
    return route = DockCupertinoRoute<T>(
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

  @override
  late final DockCupertinoRoute<T> route;
}

class DockMaterialPage<T> extends DockPage<T> {
  /// Creates a material page.
  DockMaterialPage({
    required this.builder,
    required super.key,
    required this.configuration,
    super.onExit,
    // this.initial = false,

    this.maintainState = true,
    this.fullscreenDialog = false,
    this.allowSnapshotting = true,
    this.barrierDismissible = false,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  final WidgetBuilder builder;

  @override
  final RouteConfigurationBase configuration;
  @override
  final bool maintainState;

  @override
  final bool allowSnapshotting;

  @override
  final bool barrierDismissible;

  @override
  final bool fullscreenDialog;

  @override
  late final DockMaterialRoute<T> route;

  @override
  DockMaterialRoute<T> createRoute(BuildContext context) {
    return route = DockMaterialRoute<T>(
      page: this,
      allowSnapshotting: allowSnapshotting,
      barrierDismissible: barrierDismissible,
      fullscreenDialog: fullscreenDialog,
    );
  }
}
