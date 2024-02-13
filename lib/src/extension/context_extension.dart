import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  DockRouterBase get router => DockRouter.of(this);
}
