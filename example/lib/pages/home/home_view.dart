import 'package:dock_router_example/main.dart';
import 'package:dock_router_example/product/constants/route_names.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Hero(
          tag: 'Hero Anim Test',
          child: ElevatedButton(
            onPressed: () async {
              router.push(RouteNames.sampleTabPage);
            },
            child: const Text('Some button'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey().toString(),
        onPressed: router.pop,
        label: const Text('Floating Action Button'),
        icon: const Icon(Icons.delete_outline_rounded),
      ),
    );
  }
}
