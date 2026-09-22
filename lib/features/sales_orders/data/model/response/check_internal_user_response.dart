import 'package:json_annotation/json_annotation.dart';

part 'check_internal_user_response.g.dart';

@JsonSerializable()
class CheckInternalUserResponse {
  final dynamic result;

  const CheckInternalUserResponse({
    this.result,
  });

  factory CheckInternalUserResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CheckInternalUserResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckInternalUserResponseToJson(this);

  bool get isInternalUser => result == true;
}