import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/login/domain/use_case/login_use_case.dart';
import 'package:task2shomewear/features/login/presentation/manager/login/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase)
      : super(const LoginInitialState());

  void changeRememberMe(bool value) {
    emit(
      LoginInitialState(
        isFormValid: state.isFormValid,
        rememberMe: value,
      ),
    );
  }

  void validateForm(bool isValid) {
    emit(
      LoginInitialState(
        isFormValid: isValid,
        rememberMe: state.rememberMe,
      ),
    );
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final currentRememberMe = state.rememberMe;
    final currentFormValid = state.isFormValid;

    emit(
      LoginLoadingState(
        isFormValid: currentFormValid,
        rememberMe: currentRememberMe,
      ),
    );

    final resultLogin = await _loginUseCase.call(
      email: email.trim(),
      password: password.trim(),
      rememberMe: currentRememberMe,
    );

    switch (resultLogin) {
      case Success<int>():
        emit(
          LoginSuccessState(
            userId: resultLogin.data,
            isFormValid: currentFormValid,
            rememberMe: currentRememberMe,
          ),
        );

      case Failure<int>():
        emit(
          LoginFailureState(
            errorMessage: resultLogin.errorMessage,
            isFormValid: currentFormValid,
            rememberMe: currentRememberMe,
          ),
        );
    }
  }
}