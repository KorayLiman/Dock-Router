import 'dart:io';

import 'package:dock_router/src/page/dock_page.dart';
import 'package:flutter/material.dart';

abstract class RouteConfigurationBase {
  String get name;

  Widget get child;

  bool get fullscreenDialog;

  bool get allowSnapshotting;

  bool get barrierDismissible;

  bool get maintainState;

  String? get restorationId;

  bool get initial;

  ExitCallback? get onExit;

  List<TabRouteConfiguration> get children;

  DockPage<T> createPage<T>([Object? arguments]);
}

class RouteConfiguration extends RouteConfigurationBase {
  RouteConfiguration({
    required this.name,
    required this.child,
    this.initial = false,
    this.children = const [],
    this.onExit,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.barrierDismissible = false,
    this.maintainState = true,
    this.restorationId,
  })  : assert(Platform.isAndroid || Platform.isIOS, 'DockRouter only supports Android and iOS'),
        assert(name.contains('/'), 'Route names must start with /');

  @override
  final String name;

  @override
  final Widget child;

  @override
  final bool fullscreenDialog;

  @override
  final bool allowSnapshotting;

  @override
  final bool barrierDismissible;

  @override
  final bool maintainState;

  @override
  final String? restorationId;

  @override
  final ExitCallback? onExit;

  @override
  final bool initial;

  @override
  final List<TabRouteConfiguration> children;

  @override
  DockPage<T> createPage<T>([Object? arguments]) {
    return Platform.isIOS
        ? DockCupertinoPage<T>(
            name: name,
            key: UniqueKey(),
            child: child,
            allowSnapshotting: allowSnapshotting,
            fullscreenDialog: fullscreenDialog,
            barrierDismissible: barrierDismissible,
            onExit: onExit,
            restorationId: restorationId,
            maintainState: maintainState,
            arguments: arguments,
          )
        : DockMaterialPage<T>(
            name: name,
            key: UniqueKey(),
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

class TabRouteConfiguration extends RouteConfigurationBase {
  TabRouteConfiguration({
    required this.name,
    required this.child,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.barrierDismissible = false,
    this.maintainState = true,
    this.restorationId,
    this.onExit,
  })  : assert(Platform.isAndroid || Platform.isIOS, 'DockRouter only supports Android and iOS'),
        assert(!name.contains('/'), 'Route names cannot start with /');

  @override
  final String name;

  @override
  final Widget child;

  @override
  final bool fullscreenDialog;

  @override
  final bool allowSnapshotting;

  @override
  final bool barrierDismissible;

  @override
  final bool maintainState;

  @override
  final String? restorationId;

  @override
  final ExitCallback? onExit;

  @override
  final bool initial = false;

  @override
  List<TabRouteConfiguration> get children => [];

  @override
  DockPage<T> createPage<T>([Object? arguments]) {
    return Platform.isIOS
        ? DockCupertinoPage<T>(
            name: name,
            key: UniqueKey(),
            child: child,
            allowSnapshotting: allowSnapshotting,
            fullscreenDialog: fullscreenDialog,
            barrierDismissible: barrierDismissible,
            onExit: onExit,
            restorationId: restorationId,
            maintainState: maintainState,
            arguments: arguments,
          )
        : DockMaterialPage<T>(
            name: name,
            key: UniqueKey(),
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
