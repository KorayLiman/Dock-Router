import 'package:dock_router/dock_router.dart';
import 'package:dock_router_example/product/constants/route_names.dart';
import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  const Tab2({super.key});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    print('Tab2 build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab 2'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                DockRouter.of(context).push(RouteNames.dummyRoute);
              },
              child: const Text('Tab 2'),
            ),
            Text('$_counter'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey().toString(),
        onPressed: () {
          setState(() => _counter++);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
