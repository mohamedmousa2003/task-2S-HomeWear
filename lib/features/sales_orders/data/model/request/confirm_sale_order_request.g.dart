// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_sale_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmSaleOrderRequest _$ConfirmSaleOrderRequestFromJson(
  Map<String, dynamic> json,
) => ConfirmSaleOrderRequest(
  jsonrpc: json['jsonrpc'] as String? ?? '2.0',
  method: json['method'] as String? ?? 'call',
  params: ConfirmSaleOrderParams.fromJson(
    json['params'] as Map<String, dynamic>,
  ),
  id: (json['id'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$ConfirmSaleOrderRequestToJson(
  ConfirmSaleOrderRequest instance,
) => <String, dynamic>{
  'jsonrpc': instance.jsonrpc,
  'method': instance.method,
  'params': instance.params.toJson(),
  'id': instance.id,
};

ConfirmSaleOrderParams _$ConfirmSaleOrderParamsFromJson(
  Map<String, dynamic> json,
) => ConfirmSaleOrderParams(
  service: json['service'] as String? ?? 'object',
  method: json['method'] as String? ?? 'execute_kw',
  args: json['args'] as List<dynamic>,
);

Map<String, dynamic> _$ConfirmSaleOrderParamsToJson(
  ConfirmSaleOrderParams instance,
) => <String, dynamic>{
  'service': instance.service,
  'method': instance.method,
  'args': instance.args,
};
