import 'dart:async';

import 'package:dock_router/src/page/dock_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class DockRouteBase<T> {
  DockPageBase<T> get page;

  Completer<Object>? completer;
}

class DockMaterialRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> implements DockRouteBase<T> {
  DockMaterialRoute({
    required DockMaterialPage<T> page,
    super.allowSnapshotting,
    super.barrierDismissible,
    super.fullscreenDialog,
  }) : super(settings: page) {
    assert(opaque);
  }

  @override
  DockMaterialPage<T> get page => settings as DockMaterialPage<T>;

  @override
  Completer<Object>? completer;

  @override
  Widget buildContent(BuildContext context) => page.child;

  @override
  bool get maintainState => page.maintainState;

  @override
  bool get fullscreenDialog => page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${page.name})';
}

class DockCupertinoRoute<T> extends PageRoute<T> with CupertinoRouteTransitionMixin<T> implements DockRouteBase<T> {
  DockCupertinoRoute({
    required DockCupertinoPage<T> page,
    super.allowSnapshotting,
    super.barrierDismissible,
    super.fullscreenDialog,
  }) : super(settings: page) {
    assert(opaque);
  }

  @override
  DockCupertinoPage<T> get page => settings as DockCupertinoPage<T>;

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
  Completer<Object>? completer;
}
