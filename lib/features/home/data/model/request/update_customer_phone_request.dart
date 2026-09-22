import 'package:json_annotation/json_annotation.dart';

part 'update_customer_phone_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateCustomerPhoneRequest {
  @JsonKey(name: "jsonrpc")
  final String? jsonrpc;

  @JsonKey(name: "method")
  final String? method;

  @JsonKey(name: "params")
  final UpdatePhoneParams? params;

  @JsonKey(name: "id")
  final int? id;

  UpdateCustomerPhoneRequest({
    this.jsonrpc = "2.0",
    this.method = "call",
    required this.params,
    this.id = 1,
  });

  factory UpdateCustomerPhoneRequest.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$UpdateCustomerPhoneRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdateCustomerPhoneRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdatePhoneParams {
  @JsonKey(name: "service")
  final String? service;

  @JsonKey(name: "method")
  final String? method;

  @JsonKey(name: "args")
  final List<dynamic>? args;

  UpdatePhoneParams({
    this.service = "object",
    this.method = "execute_kw",
    this.args,
  });

  factory UpdatePhoneParams.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$UpdatePhoneParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdatePhoneParamsToJson(this);
}