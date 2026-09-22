// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleOrderRequest _$SaleOrderRequestFromJson(Map<String, dynamic> json) =>
    SaleOrderRequest(
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      method: json['method'] as String? ?? 'call',
      params: SaleOrderParams.fromJson(json['params'] as Map<String, dynamic>),
      id: (json['id'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$SaleOrderRequestToJson(SaleOrderRequest instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params.toJson(),
      'id': instance.id,
    };

SaleOrderParams _$SaleOrderParamsFromJson(Map<String, dynamic> json) =>
    SaleOrderParams(
      service: json['service'] as String? ?? 'object',
      method: json['method'] as String? ?? 'execute_kw',
      args: json['args'] as List<dynamic>,
    );

Map<String, dynamic> _$SaleOrderParamsToJson(SaleOrderParams instance) =>
    <String, dynamic>{
      'service': instance.service,
      'method': instance.method,
      'args': instance.args,
    };
