import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

typedef TabsBuilder = Widget Function(BuildContext context, Widget child);

class TabsRouter extends StatefulWidget {
  const TabsRouter({required this.builder, super.key});

  static TabsRouterState of(BuildContext context) {
    final state = context.findAncestorStateOfType<TabsRouterState>();
    assert(state != null, 'No TabsRouter found in context');
    return state!;
  }

  final TabsBuilder builder;

  @override
  State<TabsRouter> createState() => TabsRouterState();
}

class TabsRouterState extends State<TabsRouter> {
  late final List<DockPage<Object>> _tabs;
  late final List<TabRouteConfiguration> _tabsRoutes;
  final _activeTabListenable = ValueNotifier<int>(0);

  int get activeTabIndex => _activeTabListenable.value;

  // ignore: use_setters_to_change_properties
  void setActiveIndex(int index) {
    _activeTabListenable.value = index;
  }

  DockRoute get currentRoute => _tabs[activeTabIndex].route;

  @override
  void didChangeDependencies() {
    final currentRouter = DockRouter.of(context);
    _tabsRoutes = currentRouter.routes().firstWhere((element) => element.name == currentRouter.currentRoute.name).children;
    _tabs = _tabsRoutes.map((e) => e.createPage<Object>()).toList();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _activeTabListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _activeTabListenable,
      builder: (context, activeTabIndex, _) {
        return IndexedStack(
          index: activeTabIndex,
          children: _tabs.map((e) => widget.builder(context, e.child)).toList(),
        );
      },
    );
  }
}
