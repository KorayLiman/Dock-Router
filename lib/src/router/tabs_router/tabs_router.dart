import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

typedef TabsWidgetBuilder = Widget Function(BuildContext context, Widget child);

class TabsBuilder extends StatefulWidget {
  const TabsBuilder({required this.builder, super.key});

  static TabsBuilderState of(BuildContext context) {
    final state = context.findAncestorStateOfType<TabsBuilderState>();
    assert(state != null, 'No TabsBuilder found in context');
    return state!;
  }

  final TabsWidgetBuilder builder;

  @override
  State<TabsBuilder> createState() => TabsBuilderState();
}

class TabsBuilderState extends State<TabsBuilder> {
  late final List<DockPage<Object>> _tabs;
  late final List<TabRouteConfiguration> _tabsRoutes;
  final _activeTabListenable = ValueNotifier<int>(0);

  int get activeTabIndex => _activeTabListenable.value;

  // ignore: use_setters_to_change_properties
  void setActiveIndex(int index) {
    _activeTabListenable.value = index;
  }

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

    DockRouter(routes: DockRouter.of(context, rootRouter: true).routes).;
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
