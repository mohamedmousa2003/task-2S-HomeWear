import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/cache/secure_cache/cache_keys.dart';
import 'package:task2shomewear/config/cache/secure_cache/secure_cache_helper.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/login/data/data_source/remote/auth_remote_data_source.dart';
import 'package:task2shomewear/features/login/data/model/response/login_response.dart';
import 'package:task2shomewear/features/login/domain/repositories/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource);

  @override
  Future<Result<int>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final response = await _authRemoteDataSource.login(
      email: email,
      password: password,
    );

    switch (response) {
      case Success<LoginResponse>():
        final loginData = response.data;

        if (loginData.isSuccess && loginData.uid != null) {
          final int uid = loginData.uid!;

          if (rememberMe) {
            await SecureCacheHelper.saveData(
              key: CacheKeys.userId,
              value: uid.toString(),
            );

            await SecureCacheHelper.saveData(
              key: CacheKeys.email,
              value: email,
            );

            await SecureCacheHelper.saveData(
              key: CacheKeys.password,
              value: password,
            );

            await SecureCacheHelper.saveData(
              key: CacheKeys.rememberMe,
              value: 'true',
            );
          } else {
            await SecureCacheHelper.removeData(
              key: CacheKeys.userId,
            );

            await SecureCacheHelper.removeData(
              key: CacheKeys.email,
            );

            await SecureCacheHelper.removeData(
              key: CacheKeys.password,
            );

            await SecureCacheHelper.saveData(
              key: CacheKeys.rememberMe,
              value: 'false',
            );
          }

          return Success(data: uid);
        }

        return Failure(
          errorMessage:
          loginData.errorMessage ?? 'Email or password is wrong',
        );

      case Failure<LoginResponse>():
        return Failure(
          errorMessage: response.errorMessage,
        );
    }
  }
}