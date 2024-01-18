import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DockRouterApp());
}

DockRouter router = DockRouter(
    routes: () => [
          DockRoute(
              name: '/home',
              initial: true,
              child: Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () async {
                      final result = await router.push('/settings');
                      print("result: $result");
                    },
                    child: const Text('Home'),
                  ),
                ),
              )),
          DockRoute(
              name: '/settings',
              child: Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Settings'),
                      Builder(builder: (context) {
                        return TextButton(
                          onPressed: () {
                            router.pop('result from settings');
                          },
                          child: const Text('Pop'),
                        );
                      }),
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
