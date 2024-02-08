import 'package:dock_router/dock_router.dart';
import 'package:dock_router_example/product/constants/route_names.dart';
import 'package:flutter/material.dart';

class Tab1 extends StatefulWidget {
  const Tab1({super.key});

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab 1'),
        leading: IconButton(
          onPressed: DockRouter.parentOf(context).pop,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                DockRouter.of(context, rootRouter: true).push(RouteNames.login);
              },
              child: const Text('Tab 1'),
            ),
            Text(_counter.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
