import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task2shomewear/features/login/data/model/request/Login.dart';
import '../../../core/values/api_end_points.dart';
import '../../../core/values/api_strings.dart';
import '../data/model/response/login_response.dart';
part 'api_client_auth_login.g.dart';

@injectable
@RestApi()
abstract class ApiClientAuthLogin {
  @factoryMethod
  factory ApiClientAuthLogin(Dio dio) = _ApiClientAuthLogin;

  /// Login
  @POST(ApiEndPoints.baseUrl)
  @Extra({ApiStrings.requireAuth: false})
  Future<LoginResponse> login(@Body() LoginRequest login);
}