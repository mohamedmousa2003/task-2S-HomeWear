import 'package:json_annotation/json_annotation.dart';

part 'sale_order_line_model.g.dart';

@JsonSerializable()
class SaleOrderLineModel {
  final int? id;

  @JsonKey(name: 'product_id')
  final dynamic productId;

  final double? productUomQty;

  @JsonKey(name: 'price_unit')
  final double? priceUnit;

  @JsonKey(name: 'price_subtotal')
  final double? priceSubtotal;

  const SaleOrderLineModel({
    this.id,
    this.productId,
    this.productUomQty,
    this.priceUnit,
    this.priceSubtotal,
  });

  factory SaleOrderLineModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$SaleOrderLineModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaleOrderLineModelToJson(this);
}