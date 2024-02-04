import 'package:flutter_test/flutter_test.dart';
import 'package:ali_dypns_sms/ali_dypns_sms.dart';
import 'package:ali_dypns_sms/ali_dypns_sms_platform_interface.dart';
import 'package:ali_dypns_sms/ali_dypns_sms_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAliDypnsSmsPlatform
    with MockPlatformInterfaceMixin
    implements AliDypnsSmsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AliDypnsSmsPlatform initialPlatform = AliDypnsSmsPlatform.instance;

  test('$MethodChannelAliDypnsSms is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAliDypnsSms>());
  });

  test('getPlatformVersion', () async {
    AliDypnsSms aliDypnsSmsPlugin = AliDypnsSms();
    MockAliDypnsSmsPlatform fakePlatform = MockAliDypnsSmsPlatform();
    AliDypnsSmsPlatform.instance = fakePlatform;

    expect(await aliDypnsSmsPlugin.getPlatformVersion(), '42');
  });
}
