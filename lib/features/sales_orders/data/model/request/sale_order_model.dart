import 'package:json_annotation/json_annotation.dart';

import 'sale_order_line_model.dart';

part 'sale_order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleOrderModel {
  final int? id;

  final String? name;

  @JsonKey(name: 'partner_id')
  final dynamic partnerId;

  @JsonKey(name: 'date_order')
  final String? dateOrder;

  final String? state;

  @JsonKey(name: 'amount_total')
  final double? amountTotal;

  @JsonKey(name: 'order_line')
  final List<SaleOrderLineModel>? orderLines;

  const SaleOrderModel({
    this.id,
    this.name,
    this.partnerId,
    this.dateOrder,
    this.state,
    this.amountTotal,
    this.orderLines,
  });

  factory SaleOrderModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$SaleOrderModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaleOrderModelToJson(this);
}