// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_sale_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmSaleOrderResponse _$ConfirmSaleOrderResponseFromJson(
  Map<String, dynamic> json,
) => ConfirmSaleOrderResponse(
  jsonrpc: json['jsonrpc'] as String?,
  id: (json['id'] as num?)?.toInt(),
  result: json['result'],
);

Map<String, dynamic> _$ConfirmSaleOrderResponseToJson(
  ConfirmSaleOrderResponse instance,
) => <String, dynamic>{
  'jsonrpc': instance.jsonrpc,
  'id': instance.id,
  'result': instance.result,
};
