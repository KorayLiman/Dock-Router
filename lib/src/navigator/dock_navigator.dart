import 'package:dock_router/src/page/dock_page.dart';
import 'package:flutter/material.dart';

class DockNavigator extends StatefulWidget {
  const DockNavigator({
    required GlobalKey<DockNavigatorState> key,
    required this.pages,
    required this.navigatorKey,
    required this.onPopPage,
  }) : super(key: key);

  final List<DockPageBase<Object>> pages;
  final GlobalKey<NavigatorState> navigatorKey;
  final bool Function(Route<dynamic> route, dynamic result) onPopPage;

  @override
  State<DockNavigator> createState() => DockNavigatorState();
}

class DockNavigatorState extends State<DockNavigator> {
  void rebuild() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      pages: widget.pages,
      onPopPage: widget.onPopPage,
    );
  }
}
