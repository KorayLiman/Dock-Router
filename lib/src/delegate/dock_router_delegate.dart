import 'dart:async';

import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/delegate/router_delegate_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DockRouterDelegate extends RouterDelegateBase {
  DockRouterDelegate(this._router) : _routes = _router.routes {
    final initialPagesIterable = _routes().where((element) => element.initial);

    assert(initialPagesIterable.length == 1, 'There should be exactly one initial page');
    _history.add(initialPagesIterable.first.createPage());
    addListener(_rebuildNavigator);
  }

  DockRouterDelegate.nested(this._router) : _routes = _router.routes {
    _history.add(_routes().first.createPage());
    addListener(_rebuildNavigator);
  }

  DockRouterDelegate.tab(this._router, int tabIndex) : _routes = _router.routes {
    _history.add(
      _routes().firstWhere((element) => element.tabIndex == tabIndex).createPage(),
    );
    addListener(_rebuildNavigator);
  }

  final DockRouterBase _router;

  final List<DockPage<Object>> _history = [];

  void _rebuildNavigator() {
    _dockNavigatorStateKey.currentState?.rebuild();
  }

  @override
  List<DockPage<Object>> get history => List.unmodifiable(_history);
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
  final List<RouteConfigurationBase> Function() _routes;
  final _dockNavigatorStateKey = GlobalKey<DockNavigatorState>();

  @override
  void dispose() {
    removeListener(() {
      _dockNavigatorStateKey.currentState?.rebuild();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DockNavigator(
      key: _dockNavigatorStateKey,
      router: _router,
      pages: history,
      navigatorKey: _navigatorKey,
      onPopPage: (route, result) {
        if (route is DockRoute) {
          final dockRoute = route as DockRoute;
          if (dockRoute.page.onExit != null) {
            scheduleMicrotask(() async {
              final onExitResult = await dockRoute.page.onExit!(_navigatorKey.currentContext!);
              if (onExitResult) {
                _history.remove(dockRoute.page);
                dockRoute.page.completePop(result);
                notifyListeners();
// TODO(KorayLiman): complete pop
              }
            });
            return false;
          } else {
            _history.remove(dockRoute.page);
            scheduleMicrotask(() {
              dockRoute.page.completePop(result);
              notifyListeners();
            });
            route.didPop(result);
            return true;
          }
        } else {
          final didPop = route.didPop(result);
          return didPop;
        }
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfigurationBase configuration) => throw UnimplementedError();

  @override
  Future<T?> push<T extends Object>(String name, {Object? arguments}) async {
    _history.add(_routes().where((element) => element.name == name).first.createPage<T>(arguments));
    notifyListeners();
    return (_history.last as DockPage<T>).waitForPop;
  }

  @override
  Future<T?> pushReplacement<T extends Object>(String name, {Object? arguments}) async {
    _history
      ..removeLast()
      ..add(_routes().where((element) => element.name == name).first.createPage<T>(arguments));
    notifyListeners();
    return (_history.last as DockPage<T>).waitForPop;
  }

  @override
  Future<T?> pushReplacementAll<T extends Object>(String name, {Object? arguments}) async {
    _history
      ..clear()
      ..add(_routes().where((element) => element.name == name).first.createPage<T>(arguments));
    notifyListeners();
    return (_history.last as DockPage<T>).waitForPop;
  }

  @override
  Future<T?> pushAll<T extends Object>(List<String> names, {Object? arguments}) async {
    for (final name in names) {
      final args = name == names.last ? arguments : null;
      _history.add(_routes().where((element) => element.name == name).first.createPage<T>(args));
    }
    notifyListeners();
    return (_history.last as DockPage<T>).waitForPop;
  }

  @override
  Future<void> pushAndRemoveUntil(String name, {Object? arguments}) async {
    assert(_history.where((element) => element.name == name).isNotEmpty, '''
        \nThere is no page with name $name in the history.
        If you want to push a page and remove all other pages, use pushReplacementAll instead.''');
    _history.add(_routes().where((element) => element.name == name).first.createPage(arguments));
    while (_history.last.name != name) {
      _history.removeLast();
    }

    notifyListeners();
  }

  @override
  Future<bool> pop<T extends Object>([T? result]) async {
    final onExitCallback = _history.last.onExit;
    if (onExitCallback == null) {
      final page = _history.removeLast();
      scheduleMicrotask(() {
        page.completePop(result);
        notifyListeners();
      });
      return SynchronousFuture(true);
    } else {
      if (onExitCallback is Future) {
        final popResult = await onExitCallback(_navigatorKey.currentContext!);
        if (popResult) {
          final page = _history.removeLast();
          scheduleMicrotask(() {
            page.completePop(result);
            notifyListeners();
          });
          return true;
        } else {
          return false;
        }
      } else {
        final popResult = await onExitCallback(_navigatorKey.currentContext!);
        if (popResult) {
          final page = _history.removeLast();
          scheduleMicrotask(() {
            page.completePop(result);
            notifyListeners();
          });
          return SynchronousFuture(true);
        } else {
          return SynchronousFuture(false);
        }
      }
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

  @override
  Future<void> removeWhere(bool Function(DockRoute route) predicate) async {
    final toBeRemoved = <DockPage<Object>>[];
    for (final page in _history) {
      if (predicate.call(page.route)) {
        final popResult = await page.onExit?.call(_navigatorKey.currentContext!) ?? true;
        if (popResult) {
          toBeRemoved.add(page);
        }
      }
    }
    _history.removeWhere(toBeRemoved.contains);
    notifyListeners();
  }
}
