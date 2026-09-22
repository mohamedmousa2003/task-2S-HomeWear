// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_customer_phone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCustomerPhoneRequest _$UpdateCustomerPhoneRequestFromJson(
  Map<String, dynamic> json,
) => UpdateCustomerPhoneRequest(
  jsonrpc: json['jsonrpc'] as String? ?? "2.0",
  method: json['method'] as String? ?? "call",
  params: json['params'] == null
      ? null
      : UpdatePhoneParams.fromJson(json['params'] as Map<String, dynamic>),
  id: (json['id'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$UpdateCustomerPhoneRequestToJson(
  UpdateCustomerPhoneRequest instance,
) => <String, dynamic>{
  'jsonrpc': instance.jsonrpc,
  'method': instance.method,
  'params': instance.params?.toJson(),
  'id': instance.id,
};

UpdatePhoneParams _$UpdatePhoneParamsFromJson(Map<String, dynamic> json) =>
    UpdatePhoneParams(
      service: json['service'] as String? ?? "object",
      method: json['method'] as String? ?? "execute_kw",
      args: json['args'] as List<dynamic>?,
    );

Map<String, dynamic> _$UpdatePhoneParamsToJson(UpdatePhoneParams instance) =>
    <String, dynamic>{
      'service': instance.service,
      'method': instance.method,
      'args': instance.args,
    };
