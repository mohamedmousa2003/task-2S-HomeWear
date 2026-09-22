import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/execute_api.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/login/api/api_client_auth_login.dart';
import 'package:task2shomewear/features/login/data/data_source/remote/auth_remote_data_source.dart';
import 'package:task2shomewear/features/login/data/model/request/Login.dart';
import 'package:task2shomewear/features/login/data/model/response/login_response.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClientAuthLogin _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  /// Login
  @override
  Future<Result<LoginResponse>> login({
    required String email,
    required String password,
  }) {
    return executeApi<LoginResponse>(() async {
      final response = await _apiClient.login(
        LoginRequest(
          params: Params(
            args: ["odoo_flutter", email, password],
          ),
        ),
      );
      return response;
    });
  }
}