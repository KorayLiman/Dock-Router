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

  static TabsBuilderState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<TabsBuilderState>();
  }

  final TabsWidgetBuilder builder;

  @override
  State<TabsBuilder> createState() => TabsBuilderState();
}

class TabsBuilderState extends State<TabsBuilder> {
  late final List<DockPage<Object>> _tabs;
  late final Iterable<RouteConfigurationBase> _childrenTabRoutes;
  final _activeTabListenable = ValueNotifier<int>(0);
  late final Map<int, bool> _indexBasedTabInitialization;

  int get activeTabIndex => _activeTabListenable.value;

  // ignore: use_setters_to_change_properties
  void setActiveIndex(int index) {
    _activeTabListenable.value = index;
  }

  @override
  void initState() {
    final parent = DockRouter.of(context) as DockRouter;
    _childrenTabRoutes = parent.routes().firstWhere((element) => element.name == parent.currentRoute.name).children.where((element) => element.tabIndex != null);
    _tabs = _childrenTabRoutes.map((e) => e.createPage<Object>()).toList();
    _indexBasedTabInitialization = Map.fromEntries(
      _tabs.map(
        (e) => MapEntry(_tabs.indexOf(e), false),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _activeTabListenable.dispose();
    super.dispose();
  }

  Widget _buildWidgetLazy(BuildContext context, int index) {
    if (activeTabIndex != index) {
      return _indexBasedTabInitialization[index] == false
          ? const SizedBox.shrink()
          : widget.builder(
              context,
              NestedRouter.tab(
                key: _childrenTabRoutes.firstWhere((element) => element.tabIndex == index).nestedRouterKey,
                tabIndex: index,
              ),
            );
    }

    if (_indexBasedTabInitialization[index] == false) {
      _indexBasedTabInitialization[index] = true;
    }
    return widget.builder(
      context,
      NestedRouter.tab(
        key: _childrenTabRoutes.firstWhere((element) => element.tabIndex == index).nestedRouterKey,
        tabIndex: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _activeTabListenable,
      builder: (context, activeTabIndex, _) {
        return IndexedStack(
          index: activeTabIndex,
          children: List.generate(
            _tabs.length,
            (index) => _buildWidgetLazy(context, index),
          ),
        );
      },
    );
  }
}
