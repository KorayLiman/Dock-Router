import 'dart:async';

import 'package:dock_router/src/route/dock_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ExitCallback = FutureOr<bool> Function(BuildContext context);

abstract class DockPageBase<T> extends Page<T> {
  const DockPageBase({
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  bool get initial;

  String get pageName;

  LocalKey get pageKey;
}

class DockCupertinoPage<T> extends DockPageBase<T> {
  /// Creates a cupertino page.
  DockCupertinoPage({
    required this.child,
    this.initial = false,
    this.maintainState = true,
    this.title,
    this.fullscreenDialog = false,
    this.allowSnapshotting = true,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(key: ValueKey(name));

  final Widget child;

  final String? title;

  final bool maintainState;

  final bool fullscreenDialog;

  final bool allowSnapshotting;

  @override
  DockCupertinoRoute<T> createRoute(BuildContext context) {
    return DockCupertinoRoute(
      page: this,
      allowSnapshotting: allowSnapshotting,
    );
  }

  @override
  final bool initial;

  @override
  LocalKey get pageKey => key!;

  @override
  String get pageName {
    assert(name != null, 'name of page must not be null');
    return name!;
  }
}

class DockMaterialPage<T> extends DockPageBase<T> {
  /// Creates a material page.
  DockMaterialPage({
    required this.child,
    this.initial = false,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.allowSnapshotting = true,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(key: ValueKey(name));

  final Widget child;

  final bool maintainState;

  final bool fullscreenDialog;

  final bool allowSnapshotting;

  @override
  final bool initial;

  @override
  Route<T> createRoute(BuildContext context) {
    return DockMaterialRoute(page: this, allowSnapshotting: allowSnapshotting);
  }

  @override
  LocalKey get pageKey => key!;

  @override
  String get pageName {
    assert(name != null, 'name of page must not be null');
    return name!;
  }
}
