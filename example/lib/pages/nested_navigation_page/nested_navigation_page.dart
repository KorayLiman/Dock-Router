
import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class NestedNavigationPage extends StatefulWidget {
  const NestedNavigationPage({super.key});

  @override
  State<NestedNavigationPage> createState() => _NestedNavigationPageState();
}

class _NestedNavigationPageState extends State<NestedNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return NestedRouter(routes: ()=>);
  }
}
