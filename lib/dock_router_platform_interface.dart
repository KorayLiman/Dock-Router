import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dock_router_method_channel.dart';

abstract class DockRouterPlatform extends PlatformInterface {
  /// Constructs a DockRouterPlatform.
  DockRouterPlatform() : super(token: _token);

  static final Object _token = Object();

  static DockRouterPlatform _instance = MethodChannelDockRouter();

  /// The default instance of [DockRouterPlatform] to use.
  ///
  /// Defaults to [MethodChannelDockRouter].
  static DockRouterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DockRouterPlatform] when
  /// they register themselves.
  static set instance(DockRouterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
