import 'dart:convert';

import 'package:ali_dypns_sms/AliDypnsSmsResult.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ali_dypns_sms_platform_interface.dart';

/// An implementation of [AliDypnsSmsPlatform] that uses method channels.
class MethodChannelAliDypnsSms extends AliDypnsSmsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ali_dypns_sms');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<AliDypnsSmsResult?> sendSms(String phoneNumber, String sceneCode) async {
    String? result =
        await methodChannel.invokeMethod<String>('sendSms', {'phoneNumber': phoneNumber, 'sceneCode': sceneCode});

    if (result == null) return null;
    return AliDypnsSmsResult.fromJson(jsonDecode(result));
  }
}
