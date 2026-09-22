// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerListRequest _$CustomerListRequestFromJson(Map<String, dynamic> json) =>
    CustomerListRequest(
      jsonrpc: json['jsonrpc'] as String? ?? "2.0",
      method: json['method'] as String? ?? "call",
      params: json['params'] == null
          ? null
          : Params.fromJson(json['params'] as Map<String, dynamic>),
      id: (json['id'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$CustomerListRequestToJson(
  CustomerListRequest instance,
) => <String, dynamic>{
  'jsonrpc': instance.jsonrpc,
  'method': instance.method,
  'params': instance.params?.toJson(),
  'id': instance.id,
};

Params _$ParamsFromJson(Map<String, dynamic> json) => Params(
  service: json['service'] as String? ?? "object",
  method: json['method'] as String? ?? "execute_kw",
  args: json['args'] as List<dynamic>?,
);

Map<String, dynamic> _$ParamsToJson(Params instance) => <String, dynamic>{
  'service': instance.service,
  'method': instance.method,
  'args': instance.args,
};
