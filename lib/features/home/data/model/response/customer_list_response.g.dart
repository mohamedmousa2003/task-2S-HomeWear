// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerListResponse _$CustomerListResponseFromJson(
  Map<String, dynamic> json,
) => CustomerListResponse(
  jsonrpc: json['jsonrpc'] as String?,
  id: (json['id'] as num?)?.toInt(),
  result: (json['result'] as List<dynamic>?)
      ?.map((e) => CustomerModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CustomerListResponseToJson(
  CustomerListResponse instance,
) => <String, dynamic>{
  'jsonrpc': instance.jsonrpc,
  'id': instance.id,
  'result': instance.result?.map((e) => e.toJson()).toList(),
};

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: (json['id'] as num?)?.toInt(),
      name: CustomerModel._parseNullableString(json['name']),
      phone: CustomerModel._parseNullableString(json['phone']),
      city: CustomerModel._parseNullableString(json['city']),
      email: CustomerModel._parseNullableString(json['email']),
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'city': instance.city,
      'email': instance.email,
    };
