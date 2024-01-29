import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class SampleTabPage extends StatelessWidget {
  const SampleTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TabsBuilder(
      builder: (context, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: TabsBuilder.of(context).setActiveIndex,
            selectedIndex: TabsBuilder.of(context).activeTabIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.business), label: 'Business'),
            ],
          ),
        );
      },
    );
  }
}
