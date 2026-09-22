// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleOrderModel _$SaleOrderModelFromJson(Map<String, dynamic> json) =>
    SaleOrderModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      partnerId: json['partner_id'],
      dateOrder: json['date_order'] as String?,
      state: json['state'] as String?,
      amountTotal: (json['amount_total'] as num?)?.toDouble(),
      orderLines: (json['order_line'] as List<dynamic>?)
          ?.map((e) => SaleOrderLineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SaleOrderModelToJson(SaleOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'partner_id': instance.partnerId,
      'date_order': instance.dateOrder,
      'state': instance.state,
      'amount_total': instance.amountTotal,
      'order_line': instance.orderLines?.map((e) => e.toJson()).toList(),
    };
