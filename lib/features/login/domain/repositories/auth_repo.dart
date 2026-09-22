import 'package:task2shomewear/config/error_handling/result.dart';

abstract interface class AuthRepo {
  Future<Result<int>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });
}