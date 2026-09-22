import 'package:json_annotation/json_annotation.dart';

part 'sale_order_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleOrderRequest {
  @JsonKey(name: 'jsonrpc')
  final String jsonrpc;

  final String method;

  final SaleOrderParams params;

  final int id;

  const SaleOrderRequest({
    this.jsonrpc = '2.0',
    this.method = 'call',
    required this.params,
    this.id = 1,
  });

  factory SaleOrderRequest.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$SaleOrderRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaleOrderRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SaleOrderParams {
  final String service;
  final String method;
  final List<dynamic> args;

  const SaleOrderParams({
    this.service = 'object',
    this.method = 'execute_kw',
    required this.args,
  });

  factory SaleOrderParams.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$SaleOrderParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaleOrderParamsToJson(this);
}