import 'package:json_annotation/json_annotation.dart';

part 'update_customer_phone_response.g.dart';

@JsonSerializable()
class UpdateCustomerPhoneResponse {
  @JsonKey(name: "jsonrpc")
  final String? jsonrpc;

  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "result")
  final bool? result;

  UpdateCustomerPhoneResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  factory UpdateCustomerPhoneResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$UpdateCustomerPhoneResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdateCustomerPhoneResponseToJson(this);

  bool get isSuccess => result == true;
}