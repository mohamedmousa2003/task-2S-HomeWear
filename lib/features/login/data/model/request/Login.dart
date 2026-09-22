import 'package:json_annotation/json_annotation.dart';

part 'Login.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: "jsonrpc")
  final String jsonrpc;
  @JsonKey(name: "method")
  final String method;
  @JsonKey(name: "params")
  final Params params;
  @JsonKey(name: "id")
  final int id;

  LoginRequest({
    this.jsonrpc = "2.0",
    this.method = "call",
    required this.params,
    this.id = 1,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return _$LoginRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginRequestToJson(this);
  }
}

@JsonSerializable()
class Params {
  @JsonKey(name: "service")
  final String service;
  @JsonKey(name: "method")
  final String method;
  @JsonKey(name: "args")
  final List<dynamic> args;

  Params({
    this.service = "common",
    this.method = "login",
    required this.args,
  });

  factory Params.fromJson(Map<String, dynamic> json) {
    return _$ParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ParamsToJson(this);
  }
}