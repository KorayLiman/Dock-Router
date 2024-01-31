import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class NestedRouter extends StatefulWidget {
  const NestedRouter({super.key});

  @override
  State<NestedRouter> createState() => _NestedRouterState();
}

class _NestedRouterState extends State<NestedRouter> {
  late final _parentRouter;
  @override
  void initState() {
    _parentRouter = DockRouter.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Router(routerDelegate: routerDelegate);
  }
}
