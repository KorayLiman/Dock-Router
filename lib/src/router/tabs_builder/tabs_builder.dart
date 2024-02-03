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
  late final List<Widget> _tabWidgets;
  final _activeTabListenable = ValueNotifier<int>(0);

  int get activeTabIndex => _activeTabListenable.value;

  // ignore: use_setters_to_change_properties
  void setActiveIndex(int index) {
    _activeTabListenable.value = index;
    if (_tabWidgets[index] is! _Placeholder) {}
  }

  @override
  void initState() {
    final parent = DockRouter.of(context) as DockRouter;

    _tabs = parent.routes().firstWhere((element) => element.name == parent.currentRoute.name).children.map((e) => e.createPage<Object>()).toList();
    _tabWidgets = List.generate(_tabs.length, (index) => const _Placeholder());

    super.initState();
  }

  @override
  void dispose() {
    _activeTabListenable.dispose();
    super.dispose();
  }

  Widget _buildWidgetLazy(BuildContext context, int index) {
    if (activeTabIndex == index && _tabWidgets[index] is _Placeholder) {
      _tabWidgets[index] = widget.builder(
        context,
        NestedRouter.tab(tabIndex: index),
      );
    }
    return _tabWidgets[index];
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

class _Placeholder extends StatelessWidget {
  const _Placeholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
