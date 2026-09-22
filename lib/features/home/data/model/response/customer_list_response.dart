import 'package:json_annotation/json_annotation.dart';

part 'customer_list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerListResponse {
  @JsonKey(name: "jsonrpc")
  final String? jsonrpc;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "result")
  final List<CustomerModel>? result;

  CustomerListResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  factory CustomerListResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerListResponseToJson(this);
}

@JsonSerializable()
class CustomerModel {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name", fromJson: _parseNullableString)
  final String? name;

  @JsonKey(name: "phone", fromJson: _parseNullableString)
  final String? phone;

  @JsonKey(name: "city", fromJson: _parseNullableString)
  final String? city;

  @JsonKey(name: "email", fromJson: _parseNullableString)
  final String? email;

  CustomerModel({
    this.id,
    this.name,
    this.phone,
    this.city,
    this.email,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CustomerModelToJson(this);

  static String? _parseNullableString(dynamic value) {
    if (value is String) {
      return value;
    }

    return null;
  }
}