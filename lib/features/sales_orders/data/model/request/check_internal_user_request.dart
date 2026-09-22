import 'package:json_annotation/json_annotation.dart';

part 'check_internal_user_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckInternalUserRequest {
  @JsonKey(name: 'jsonrpc')
  final String jsonrpc;

  final String method;

  final CheckInternalUserParams params;

  final int id;

  const CheckInternalUserRequest({
    this.jsonrpc = '2.0',
    this.method = 'call',
    required this.params,
    this.id = 1,
  });

  factory CheckInternalUserRequest.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CheckInternalUserRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckInternalUserRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CheckInternalUserParams {
  final String service;
  final String method;
  final List<dynamic> args;

  const CheckInternalUserParams({
    this.service = 'object',
    this.method = 'execute_kw',
    required this.args,
  });

  factory CheckInternalUserParams.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CheckInternalUserParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckInternalUserParamsToJson(this);
}