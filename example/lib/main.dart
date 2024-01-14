import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DockRouterApp());
}

DockRouter router = DockRouter(pages: [
  DockMaterialPage(
    name: '/home',
    initial: true,
    child: Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            router.push('/settings');
          },
          child: const Text('Home'),
        ),
      ),
    ),
  ),
  DockMaterialPage(
    name: '/settings',
    child: Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Settings'),
      ),
    ),
  ),
]);

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
