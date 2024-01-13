import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dock_router_platform_interface.dart';

/// An implementation of [DockRouterPlatform] that uses method channels.
class MethodChannelDockRouter extends DockRouterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dock_router');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
