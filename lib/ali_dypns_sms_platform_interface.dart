import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'AliDypnsSmsResult.dart';
import 'ali_dypns_sms_method_channel.dart';

abstract class AliDypnsSmsPlatform extends PlatformInterface {
  /// Constructs a AliDypnsSmsPlatform.
  AliDypnsSmsPlatform() : super(token: _token);

  static final Object _token = Object();

  static AliDypnsSmsPlatform _instance = MethodChannelAliDypnsSms();

  /// The default instance of [AliDypnsSmsPlatform] to use.
  ///
  /// Defaults to [MethodChannelAliDypnsSms].
  static AliDypnsSmsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AliDypnsSmsPlatform] when
  /// they register themselves.
  static set instance(AliDypnsSmsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<AliDypnsSmsResult?> sendSms(String phoneNumber, String sceneCode) {
    throw UnimplementedError('sendSms() has not been implemented.');
  }
}
