part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String emailError;
  final String passwordError;

  const LoginState({
    this.emailError = 'Alamat email harus diisi',
    this.passwordError = 'Password harus diisi',
  });

  @override
  List<Object?> get props => [emailError, passwordError];
}

class InitialState extends LoginState {}

class LoadingState extends LoginState {
  const LoadingState({
    super.emailError = '',
    super.passwordError = '',
  });
}

class SuccessState extends LoginState {}

class FailedState extends LoginState {
  final String message;

  const FailedState({
    required this.message,
    super.emailError = '',
    super.passwordError = '',
  });

  @override
  List<Object?> get props => [message, ...super.props];
}
