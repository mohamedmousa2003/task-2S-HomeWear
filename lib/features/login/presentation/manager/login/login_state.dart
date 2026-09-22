import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  final bool isFormValid;
  final bool rememberMe;

  const LoginState({
    this.isFormValid = false,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [
    isFormValid,
    rememberMe,
  ];
}

class LoginInitialState extends LoginState {
  const LoginInitialState({
    super.isFormValid,
    super.rememberMe,
  });
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState({
    super.isFormValid,
    super.rememberMe,
  });
}

class LoginSuccessState extends LoginState {
  final int userId;

  const LoginSuccessState({
    required this.userId,
    super.isFormValid,
    super.rememberMe,
  });

  @override
  List<Object?> get props => [
    userId,
    isFormValid,
    rememberMe,
  ];
}

class LoginFailureState extends LoginState {
  final String errorMessage;

  const LoginFailureState({
    required this.errorMessage,
    super.isFormValid,
    super.rememberMe,
  });

  @override
  List<Object?> get props => [
    errorMessage,
    isFormValid,
    rememberMe,
  ];
}