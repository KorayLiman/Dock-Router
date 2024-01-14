import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/navigator/dock_navigator.dart';
import 'package:dock_router/src/router/dock_router_inherited.dart';
import 'package:flutter/material.dart';

abstract class RootRouterDelegate<T> extends RouterDelegate<T> with ChangeNotifier {}

class DockRouterDelegate<T> extends RootRouterDelegate<T> {
  DockRouterDelegate(this._router, {required this.pages}) {
    final initialPageList = pages.where((element) => element.initial).toList();
    assert(initialPageList.length == 1, 'There should be exactly one initial page');
    _history.add(initialPageList.first);
    addListener(() {
      _dockNavigatorStateKey.currentState?.rebuild();
    });
  }

  final DockRouter _router;

  List<DockPageBase<Object>> _history = [];
  final _navigatorKey = GlobalKey<NavigatorState>();
  final List<DockPageBase<Object>> pages;
  final _dockNavigatorStateKey = GlobalKey<DockNavigatorState>();

  // GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // List<DockPage<Object>> get history => _history;

  @override
  void dispose() {
    removeListener(() {
      _dockNavigatorStateKey.currentState?.rebuild();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedDockRouter(
      router: _router,
      child: DockNavigator(
        key: _dockNavigatorStateKey,
        pages: _history,
        navigatorKey: _navigatorKey,
        onPopPage: (route, result) {
          print((route as DockRouteBase).page.name);
          return route.didPop(result);
        },
      ),
    );
  }

  @override
  Future<bool> popRoute() {
    print("popping");
    // TODO: implement popRoute
    throw UnimplementedError();
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }

  Future<R?> push<R extends Object?>(String name, {Object? arguments}) async {
    final temp = List<DockPageBase<Object>>.from(_history)..add(pages.where((element) => element.pageName == name).first);
    _history = temp;
    notifyListeners();
    return null;
  }

  // void pop(T result) {
  //   final temp = List<DockPage<Object>>.from(_history)..removeLast();
  //   _history = temp;
  //   notifyListeners();
  // }
}
