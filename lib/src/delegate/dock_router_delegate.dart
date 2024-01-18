import 'dart:async';

import 'package:dock_router/dock_router.dart';
import 'package:dock_router/src/navigator/dock_navigator.dart';
import 'package:dock_router/src/router/dock_router_inherited.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class RootRouterDelegate<R> extends RouterDelegate<R> with ChangeNotifier {}

class DockRouterDelegate<R> extends RootRouterDelegate<R> {
  DockRouterDelegate(this._router, this._initialRoutes) {
    final initialPageList = _initialRoutes().where((element) => element.initial).toList();
    assert(initialPageList.length == 1, 'There should be exactly one initial page');
    _history.add(initialPageList.first.createPage());
    addListener(() {
      _dockNavigatorStateKey.currentState?.rebuild();
    });
  }

  final DockRouter _router;

  List<DockPage<Object>> _history = [];

  List<DockPage<Object>> get history => List.unmodifiable(_history);
  final _navigatorKey = GlobalKey<NavigatorState>();
  final List<DockRoute<Object>> Function() _initialRoutes;
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
        pages: history,
        navigatorKey: _navigatorKey,
        onPopPage: (route, result) {
          final page = route.settings;
          if (page is DockPage) {
            if (page.onExit != null) {
              scheduleMicrotask(() async {
                final onExitResult = await page.onExit!(_navigatorKey.currentContext!);
                if (onExitResult) {
                  // TODO(KorayLiman): complete pop
                }
              });
              return false;
            } else {
              final didPop = route.didPop(result);
              if (!didPop) return false;
              _history.remove(page);
              scheduleMicrotask(() {
                page.completePop(result);
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
    final page = _history.last;
    final temp = List<DockPage<Object>>.from(_history)..removeLast();
    _history = temp;
    notifyListeners();
    debugPrint('popped page: ${page.name}');
    page.completePop(null);
    return SynchronousFuture(true);
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }

  Future<T?> push<T>(String name, {Object? arguments}) async {
    _history.add(_initialRoutes().where((element) => element.name == name).first.createPage(arguments));
    notifyListeners();
    return (_history.last as DockPage<T>).waitForPop;
  }

  void pop<T>([T? result]) {
    final last = _history.removeLast();
    notifyListeners();
    scheduleMicrotask(() {
      last.completePop(result);
    });
  }
}
