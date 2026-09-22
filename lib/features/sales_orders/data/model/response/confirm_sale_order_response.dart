import 'package:json_annotation/json_annotation.dart';

part 'confirm_sale_order_response.g.dart';

@JsonSerializable()
class ConfirmSaleOrderResponse {
  @JsonKey(name: 'jsonrpc')
  final String? jsonrpc;

  final int? id;

  final dynamic result;

  const ConfirmSaleOrderResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  factory ConfirmSaleOrderResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ConfirmSaleOrderResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConfirmSaleOrderResponseToJson(this);

  bool get isSuccess => result != null && result != false;
}