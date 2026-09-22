// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      jsonrpc: json['jsonrpc'] as String?,
      id: (json['id'] as num?)?.toInt(),
      result: json['result'],
      error: json['error'] == null
          ? null
          : OdooError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.result,
      'error': instance.error,
    };

OdooError _$OdooErrorFromJson(Map<String, dynamic> json) => OdooError(
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : OdooErrorData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OdooErrorToJson(OdooError instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'data': instance.data,
};

OdooErrorData _$OdooErrorDataFromJson(Map<String, dynamic> json) =>
    OdooErrorData(message: json['message'] as String?);

Map<String, dynamic> _$OdooErrorDataToJson(OdooErrorData instance) =>
    <String, dynamic>{'message': instance.message};
