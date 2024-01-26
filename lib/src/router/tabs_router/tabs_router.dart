import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';




//
// class TabsRouter extends DockRouterBase implements RouterConfig<Object> {
//   TabsRouter({
//     required this.tabRoutes,
//     required this.parentRouter,
//     required this.backButtonDispatcher,
//   });
//
//   var _tabIndex = 0;
//
//   int get tabIndex => _tabIndex;
//
//   final List<TabRouteConfiguration> Function() tabRoutes;
//
//   final DockRouterBase parentRouter;
//
//   @override
//   Object? get arguments => parentRouter.history.last.arguments;
//
//   @override
//   final BackButtonDispatcher backButtonDispatcher;
//
//   @override
//   // TODO: implement currentRoute
//   DockRoute get currentRoute => throw UnimplementedError();
//
//   @override
//   List<DockPage<Object>> get history => List.unmodifiable(routerDelegate.history);
//
//   @override
//   late final TabsRouterDelegate<Object> routerDelegate;
//
//   @override
//   Future<bool> pop<T extends Object>([T? result]) {
//     // TODO: implement pop
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> popBelow() {
//     // TODO: implement popBelow
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> popUntil(String name) {
//     // TODO: implement popUntil
//     throw UnimplementedError();
//   }
//
//   @override
//   // TODO: implement previousRoute
//   DockRoute? get previousRoute => throw UnimplementedError();
//
//   @override
//   Future<T?> push<T extends Object>(String name, {Object? arguments}) {
//     // TODO: implement push
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<T?> pushAll<T extends Object>(List<String> names, {Object? arguments}) {
//     // TODO: implement pushAll
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> pushAndRemoveUntil(String name, {Object? arguments}) {
//     // TODO: implement pushAndRemoveUntil
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<T?> pushReplacement<T extends Object>(String name, {Object? arguments}) {
//     // TODO: implement pushReplacement
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<T?> pushReplacementAll<T extends Object>(String name, {Object? arguments}) {
//     // TODO: implement pushReplacementAll
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> removeWhere(bool Function(DockRoute route) predicate) {
//     // TODO: implement removeWhere
//     throw UnimplementedError();
//   }
//
//   @override
//   // TODO: implement routeInformationParser
//   RouteInformationParser<Object>? get routeInformationParser => throw UnimplementedError();
//
//   @override
//   // TODO: implement routeInformationProvider
//   RouteInformationProvider? get routeInformationProvider => throw UnimplementedError();
// }

class TabsRouter extends StatefulWidget {
  const TabsRouter({super.key});

  @override
  State<TabsRouter> createState() => _TabsRouterState();
}

class _TabsRouterState extends State<TabsRouter> {

 late  final DockPage<Object> _tabs;

 @override
  void initState() {
  Router.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

