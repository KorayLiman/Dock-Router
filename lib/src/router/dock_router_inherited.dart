import 'package:dock_router/src/router/dock_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InheritedDockRouter extends InheritedWidget {
  const InheritedDockRouter({
    required this.router,
    required super.child,
    super.key,
  });

  final DockRouter router;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DockRouter>('dockRouter', router));
  }

  @override
  bool updateShouldNotify(InheritedDockRouter oldWidget) => false;
}
