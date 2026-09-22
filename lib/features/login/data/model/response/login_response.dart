import 'package:json_annotation/json_annotation.dart';
import 'package:task2shomewear/core/values/app_strings.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "jsonrpc")
  final String? jsonrpc;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "result")
  final dynamic result;
  @JsonKey(name: "error")
  final OdooError? error;

  LoginResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseToJson(this);
  }

  bool get isSuccess => result is int && result != false;

  int? get uid => result is int ? result as int : null;

  String? get errorMessage {
    if (error != null) {
      return error?.data?.message ?? error?.message;
    }
    if (result == false) {
      return AppStrings.incorrectEmailOrPassword;
    }
    return null;
  }
}

@JsonSerializable()
class OdooError {
  final int? code;
  final String? message;
  final OdooErrorData? data;

  OdooError({this.code, this.message, this.data});

  factory OdooError.fromJson(Map<String, dynamic> json) => _$OdooErrorFromJson(json);
  Map<String, dynamic> toJson() => _$OdooErrorToJson(this);
}

@JsonSerializable()
class OdooErrorData {
  final String? message;

  OdooErrorData({this.message});

  factory OdooErrorData.fromJson(Map<String, dynamic> json) => _$OdooErrorDataFromJson(json);
  Map<String, dynamic> toJson() => _$OdooErrorDataToJson(this);
}