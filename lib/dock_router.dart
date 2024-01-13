
import 'dock_router_platform_interface.dart';

class DockRouter {
  Future<String?> getPlatformVersion() {
    return DockRouterPlatform.instance.getPlatformVersion();
  }
}
