class AliDypnsSmsResult {
  final String code;
  final String msg;

  const AliDypnsSmsResult({
    required this.code,
    required this.msg,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': this.code,
      'msg': this.msg,
    };
  }

  factory AliDypnsSmsResult.fromJson(Map<String, dynamic> map) {
    return AliDypnsSmsResult(
      code: map['code'] as String,
      msg: map['msg'] as String,
    );
  }
}
