import 'package:dock_router/dock_router.dart';
import 'package:dock_router_example/pages/home/home_view.dart';
import 'package:dock_router_example/pages/login/login_view.dart';
import 'package:dock_router_example/pages/sample_tab_page/tabs/tab1.dart';
import 'package:dock_router_example/product/constants/route_names.dart';
import 'package:flutter/material.dart';

import 'pages/sample_tab_page/tabs/tab2.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DockRouterApp());
}

DockRouter router = DockRouter(
  routes: () => [
    RouteConfiguration(
      initial: true,
      name: RouteNames.login,
      child: const LoginView(),
    ),
    RouteConfiguration(
      name: RouteNames.home,
      child: const HomeView(),
      onExit: (context) async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No'),
              ),
            ],
          ),
        );
        return result ?? true;
      },
    ),
    RouteConfiguration(
      name: RouteNames.nestedRouteExample,
      child: const NestedRouter(),
      children: [
        RouteConfiguration(
          name: RouteNames.tab1,
          child: const Tab1(),
        ),
        RouteConfiguration(
          name: RouteNames.tab2,
          child: const Tab2(),
        ),
        RouteConfiguration(
          name: RouteNames.dummyRoute,
          child: Scaffold(
            appBar: AppBar(),
            floatingActionButton: const FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    ),
  ],
);

class DockRouterApp extends StatelessWidget {
  const DockRouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dock Router Demo',
      routerConfig: router,
    );
  }
}
