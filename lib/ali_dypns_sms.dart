import 'package:ali_dypns_sms/AliDypnsSmsResult.dart';

import 'ali_dypns_sms_platform_interface.dart';

class AliDypnsSms {
  Future<String?> getPlatformVersion() {
    return AliDypnsSmsPlatform.instance.getPlatformVersion();
  }

  Future<AliDypnsSmsResult?> sendSms(String phoneNumber, String sceneCode) {
    return AliDypnsSmsPlatform.instance.sendSms(phoneNumber, sceneCode);
  }
}
