import 'package:json_annotation/json_annotation.dart';
import 'sale_order_model.dart';

part 'sale_order_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleOrderResponse {
  @JsonKey(name: 'jsonrpc')
  final String? jsonrpc;

  final int? id;

  final List<SaleOrderModel>? result;

  const SaleOrderResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  factory SaleOrderResponse.fromJson(
      Map<String, dynamic> json,
      ) => _$SaleOrderResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaleOrderResponseToJson(this);
}