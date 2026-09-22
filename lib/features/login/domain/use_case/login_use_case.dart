import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/login/domain/repositories/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<Result<int>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    return _authRepo.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}