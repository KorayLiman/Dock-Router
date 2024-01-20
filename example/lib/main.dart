import 'package:dock_router/dock_router.dart';
import 'package:dock_router_example/pages/home/home_view.dart';
import 'package:dock_router_example/pages/login/login_view.dart';
import 'package:dock_router_example/product/constants/route_names.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DockRouterApp());
}

DockRouter router = DockRouter(
  routes: () => [
    DockRouteConfig(
      name: RouteNames.login,
      initial: true,
      child: const LoginView(),
    ),
    DockRouteConfig(
      name: RouteNames.home,
      child: const HomeView(),
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
