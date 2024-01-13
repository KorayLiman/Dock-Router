import 'package:flutter_test/flutter_test.dart';
import 'package:dock_router/dock_router.dart';
import 'package:dock_router/dock_router_platform_interface.dart';
import 'package:dock_router/dock_router_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDockRouterPlatform
    with MockPlatformInterfaceMixin
    implements DockRouterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DockRouterPlatform initialPlatform = DockRouterPlatform.instance;

  test('$MethodChannelDockRouter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDockRouter>());
  });

  test('getPlatformVersion', () async {
    DockRouter dockRouterPlugin = DockRouter();
    MockDockRouterPlatform fakePlatform = MockDockRouterPlatform();
    DockRouterPlatform.instance = fakePlatform;

    expect(await dockRouterPlugin.getPlatformVersion(), '42');
  });
}
