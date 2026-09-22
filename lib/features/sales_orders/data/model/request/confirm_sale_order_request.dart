import 'package:json_annotation/json_annotation.dart';

part 'confirm_sale_order_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfirmSaleOrderRequest {
  @JsonKey(name: 'jsonrpc')
  final String jsonrpc;

  final String method;

  final ConfirmSaleOrderParams params;

  final int id;

  const ConfirmSaleOrderRequest({
    this.jsonrpc = '2.0',
    this.method = 'call',
    required this.params,
    this.id = 1,
  });

  factory ConfirmSaleOrderRequest.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ConfirmSaleOrderRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConfirmSaleOrderRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConfirmSaleOrderParams {
  final String service;
  final String method;
  final List<dynamic> args;

  const ConfirmSaleOrderParams({
    this.service = 'object',
    this.method = 'execute_kw',
    required this.args,
  });

  factory ConfirmSaleOrderParams.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ConfirmSaleOrderParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConfirmSaleOrderParamsToJson(this);
}