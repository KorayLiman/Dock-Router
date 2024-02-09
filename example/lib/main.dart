import 'package:dock_router/dock_router.dart';
import 'package:dock_router_example/pages/home/home_view.dart';
import 'package:dock_router_example/pages/login/login_view.dart';
import 'package:dock_router_example/pages/sample_tab_page/sample_tab_page.dart';
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
      builder: (context) => const LoginView(),
    ),
    RouteConfiguration(
      name: RouteNames.home,
      builder: (context) => const HomeView(),
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

        await Future.delayed(const Duration(milliseconds: 160));
        return result ?? true;
      },
    ),
    RouteConfiguration(
      name: RouteNames.sampleTabPage,
      builder: (context) => const SampleTabPage(),
      children: [
        RouteConfiguration.tab(
          name: RouteNames.tab1,
          tabIndex: 0,
          builder: (context) => const Tab1(),
        ),
        RouteConfiguration.tab(
          name: RouteNames.tab2,
          tabIndex: 1,
          builder: (context) => const Tab2(),
        ),
        RouteConfiguration(
          name: RouteNames.dummyRoute,
          builder: (context) => Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: DockRouter.of(context).pop,
              child: const Icon(Icons.arrow_back),
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
