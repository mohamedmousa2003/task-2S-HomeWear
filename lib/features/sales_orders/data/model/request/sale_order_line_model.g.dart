// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_order_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleOrderLineModel _$SaleOrderLineModelFromJson(Map<String, dynamic> json) =>
    SaleOrderLineModel(
      id: (json['id'] as num?)?.toInt(),
      productId: json['product_id'],
      productUomQty: (json['productUomQty'] as num?)?.toDouble(),
      priceUnit: (json['price_unit'] as num?)?.toDouble(),
      priceSubtotal: (json['price_subtotal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SaleOrderLineModelToJson(SaleOrderLineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'productUomQty': instance.productUomQty,
      'price_unit': instance.priceUnit,
      'price_subtotal': instance.priceSubtotal,
    };
