import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DockRouterApp());
}

DockRouter router = DockRouter(
    routes: () => [
          DockRouteConfig(
              name: '/home',
              initial: true,
              child: Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () async {
                      await router.push<String>('/settings', arguments: 123);
                    },
                    child: const Text('Home'),
                  ),
                ),
              )),
          DockRouteConfig(
              name: '/settings',
              child: Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Settings'),
                      Builder(
                        builder: (context) {
                          return TextButton(
                            onPressed: () async {
                              DockRouter.of(context).pop();
                            },
                            child: const Text('Pop'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )),
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
