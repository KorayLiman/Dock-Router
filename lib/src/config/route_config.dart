import 'dart:io';

import 'package:dock_router/src/page/dock_page.dart';
import 'package:flutter/material.dart';

class DockRouteConfig {
  DockRouteConfig({
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

  final ExitCallback? onExit;

  DockPage<T> createPage<T>([Object? arguments]) {
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
