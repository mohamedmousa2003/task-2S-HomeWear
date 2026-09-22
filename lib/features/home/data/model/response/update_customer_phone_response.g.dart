// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_customer_phone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCustomerPhoneResponse _$UpdateCustomerPhoneResponseFromJson(
  Map<String, dynamic> json,
) => UpdateCustomerPhoneResponse(
  jsonrpc: json['jsonrpc'] as String?,
  id: (json['id'] as num?)?.toInt(),
  result: json['result'] as bool?,
);

Map<String, dynamic> _$UpdateCustomerPhoneResponseToJson(
  UpdateCustomerPhoneResponse instance,
) => <String, dynamic>{
  'jsonrpc': instance.jsonrpc,
  'id': instance.id,
  'result': instance.result,
};
