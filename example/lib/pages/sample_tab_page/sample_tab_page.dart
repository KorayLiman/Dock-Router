import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

class SampleTabPage extends StatelessWidget {
  const SampleTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TabsBuilder(
      navigatorObserversConfig: {
        0: [DockNavigatorObserver()],
        1: [DockNavigatorObserver()],
      },
      builder: (context, child, state) {
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: state.setActiveIndex,
            selectedIndex: state.activeIndex,
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
