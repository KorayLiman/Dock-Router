import 'dart:io';

import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

abstract class RouteConfigurationBase {
  String get name;

  WidgetBuilder get builder;

  int? get tabIndex;

  bool get fullscreenDialog;

  bool get allowSnapshotting;

  bool get barrierDismissible;

  bool get maintainState;

  String? get restorationId;

  bool get initial;

  ExitCallback? get onExit;

  List<RouteConfigurationBase> get children;

  DockPage<T> createPage<T>([Object? arguments]);

  GlobalKey<NestedRouterState>? get nestedRouterKey;
}

class RouteConfiguration extends RouteConfigurationBase {
  RouteConfiguration({
    required this.name,
    required this.builder,
    this.initial = false,
    this.children = const [],
    this.onExit,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.barrierDismissible = false,
    this.maintainState = true,
    this.restorationId,
  })  : tabIndex = null,
        nestedRouterKey = null,
        assert(name.contains('/'), 'Route names must start with /');

  RouteConfiguration.tab({
    required this.name,
    required this.builder,
    this.nestedRouterKey,
    this.initial = false,
    this.children = const [],
    this.tabIndex,
    this.onExit,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.barrierDismissible = false,
    this.maintainState = true,
    this.restorationId,
  }) : assert(name.contains('/'), 'Route names must start with /');

  @override
  final String name;

  @override
  final WidgetBuilder builder;

  @override
  final int? tabIndex;

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
  final List<RouteConfiguration> children;

  @override
  final GlobalKey<NestedRouterState>? nestedRouterKey;

  @override
  DockPage<T> createPage<T>([Object? arguments]) {
    return Platform.isIOS
        ? DockCupertinoPage<T>(
            name: name,
            configuration: this,
            key: UniqueKey(),
            builder: builder,
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
            configuration: this,
            key: UniqueKey(),
            builder: builder,
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
