// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleOrderResponse _$SaleOrderResponseFromJson(Map<String, dynamic> json) =>
    SaleOrderResponse(
      jsonrpc: json['jsonrpc'] as String?,
      id: (json['id'] as num?)?.toInt(),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => SaleOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SaleOrderResponseToJson(SaleOrderResponse instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };
