import 'dart:async';

import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/navigator/dock_navigator.dart';
import 'package:dock_router/src/router/dock_router_inherited.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class RootRouterDelegate<R> extends RouterDelegate<R> with ChangeNotifier implements RoutingOperation {}

class DockRouterDelegate<R> extends RootRouterDelegate<DockRouteConfig> {
  DockRouterDelegate(this._router, this._routeConfigs) {
    final initialPageList = _routeConfigs().where((element) => element.initial).toList();
    assert(initialPageList.length == 1, 'There should be exactly one initial page');
    _history.add(initialPageList.first.createPage());
    addListener(() {
      _dockNavigatorStateKey.currentState?.rebuild();
    });
  }

  final DockRouter _router;

  final List<DockPage<Object>> _history = [];

  List<DockPage<Object>> get history => List.unmodifiable(_history);
  final _navigatorKey = GlobalKey<NavigatorState>();
  final List<DockRouteConfig> Function() _routeConfigs;
  final _dockNavigatorStateKey = GlobalKey<DockNavigatorState>();

  // GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

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
        pages: history,
        navigatorKey: _navigatorKey,
        onPopPage: (route, result) {
          if (route is DockRoute) {
            final dockRoute = route as DockRoute;
            if (dockRoute.page.onExit != null) {
              scheduleMicrotask(() async {
                final onExitResult = await dockRoute.page.onExit!(_navigatorKey.currentContext!);
                if (onExitResult) {
                  notifyListeners();
                  // TODO(KorayLiman): complete pop
                }
              });
              return false;
            } else {
              final didPop = route.didPop(result);
              if (!didPop) return false;
              _history.remove(dockRoute.page);
              scheduleMicrotask(() {
                dockRoute.page.completePop(result);
              });

              return true;
            }
          }
          return false;
        },
      ),
    );
  }

  @override
  Future<bool> popRoute() {
    if (_history.length <= 1) return SynchronousFuture(false);
    _navigatorKey.currentState?.pop();
    return SynchronousFuture(true);
  }

  @override
  Future<void> setNewRoutePath(DockRouteConfig configuration) => throw UnimplementedError();

  @override
  Future<T?> push<T extends Object>(String name, {Object? arguments}) async {
    _history.add(_routeConfigs().where((element) => element.name == name).first.createPage<T>(arguments));
    notifyListeners();
    return (_history.last as DockPage<T>).waitForPop;
  }

  @override
  Future<T?> pushReplacement<T extends Object>(String name, {Object? arguments}) async {
    _history
      ..removeLast()
      ..add(_routeConfigs().where((element) => element.name == name).first.createPage<T>(arguments));
    notifyListeners();
    return (_history.last as DockPage<T>).waitForPop;
  }

  @override
  Future<T?> pushReplacementAll<T extends Object>(String name, {Object? arguments}) async {
    _history
      ..clear()
      ..add(_routeConfigs().where((element) => element.name == name).first.createPage<T>(arguments));
    notifyListeners();
    return (_history.last as DockPage<T>).waitForPop;
  }

  @override
  void pop<T extends Object>([T? result]) {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop(result);
    }
  }

  @override
  Future<void> popUntil(String name) async {
    if (_history.where((element) => element.name == name).isEmpty) {
      throw Exception('''
        \nTried to pop until $name but there is no page with that name in the history''');
    }
    while (_history.last.name != name) {
      final popResult = await _history.last.onExit?.call(_navigatorKey.currentContext!) ?? true;
      if (popResult) {
        _history.removeLast().completePop(null);
      } else {
        break;
      }
    }
    notifyListeners();
  }

  @override
  Future<void> popBelow() async {
    final length = _history.length;
    if (length <= 1) return SynchronousFuture(null);
    while (length > 1) {
      final previousIndexOfLastItem = length - 2;
      final popResult = await _history[previousIndexOfLastItem].onExit?.call(_navigatorKey.currentContext!) ?? true;
      if (popResult) {
        _history.removeAt(previousIndexOfLastItem).completePop(null);
      } else {
        break;
      }
    }
    notifyListeners();
  }
}
