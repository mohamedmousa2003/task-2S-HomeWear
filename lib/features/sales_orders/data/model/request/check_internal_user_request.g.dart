// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_internal_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInternalUserRequest _$CheckInternalUserRequestFromJson(
  Map<String, dynamic> json,
) => CheckInternalUserRequest(
  jsonrpc: json['jsonrpc'] as String? ?? '2.0',
  method: json['method'] as String? ?? 'call',
  params: CheckInternalUserParams.fromJson(
    json['params'] as Map<String, dynamic>,
  ),
  id: (json['id'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$CheckInternalUserRequestToJson(
  CheckInternalUserRequest instance,
) => <String, dynamic>{
  'jsonrpc': instance.jsonrpc,
  'method': instance.method,
  'params': instance.params.toJson(),
  'id': instance.id,
};

CheckInternalUserParams _$CheckInternalUserParamsFromJson(
  Map<String, dynamic> json,
) => CheckInternalUserParams(
  service: json['service'] as String? ?? 'object',
  method: json['method'] as String? ?? 'execute_kw',
  args: json['args'] as List<dynamic>,
);

Map<String, dynamic> _$CheckInternalUserParamsToJson(
  CheckInternalUserParams instance,
) => <String, dynamic>{
  'service': instance.service,
  'method': instance.method,
  'args': instance.args,
};
