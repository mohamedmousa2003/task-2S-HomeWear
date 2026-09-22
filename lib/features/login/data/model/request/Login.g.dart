// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  jsonrpc: json['jsonrpc'] as String? ?? "2.0",
  method: json['method'] as String? ?? "call",
  params: Params.fromJson(json['params'] as Map<String, dynamic>),
  id: (json['id'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params,
      'id': instance.id,
    };

Params _$ParamsFromJson(Map<String, dynamic> json) => Params(
  service: json['service'] as String? ?? "common",
  method: json['method'] as String? ?? "login",
  args: json['args'] as List<dynamic>,
);

Map<String, dynamic> _$ParamsToJson(Params instance) => <String, dynamic>{
  'service': instance.service,
  'method': instance.method,
  'args': instance.args,
};
