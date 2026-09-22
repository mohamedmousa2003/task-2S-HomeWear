import 'package:json_annotation/json_annotation.dart';

part 'customer_list_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerListRequest {
  @JsonKey(name: "jsonrpc")
  final String? jsonrpc;
  @JsonKey(name: "method")
  final String? method;
  @JsonKey(name: "params")
  final Params? params;
  @JsonKey(name: "id")
  final int? id;

  CustomerListRequest({
    this.jsonrpc = "2.0",
    this.method = "call",
    required this.params,
    this.id = 1,
  });

  factory CustomerListRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerListRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Params {
  @JsonKey(name: "service")
  final String? service;
  @JsonKey(name: "method")
  final String? method;
  @JsonKey(name: "args")
  final List<dynamic>? args;

  Params({
    this.service = "object",
    this.method = "execute_kw",
    this.args,
  });

  factory Params.fromJson(Map<String, dynamic> json) =>
      _$ParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ParamsToJson(this);
}