part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String nameError;
  final String emailError;
  final String passwordError;
  final String passwordConfirmError;

  const RegisterState({
    this.nameError = 'Nama harus diisi',
    this.emailError = 'Alamat email tidak valid',
    this.passwordError =
        'Password harus memiliki panjang minimal 8 karakter, mengandung 1 huruf kapital, 1 angka dan 1 karakter spesial',
    this.passwordConfirmError =
        'Konfirmasi password harus sama dengan password yang dimasukkan',
  });

  @override
  List<Object?> get props =>
      [nameError, emailError, passwordError, passwordConfirmError];
}

class InitialState extends RegisterState {}

class LoadingState extends RegisterState {
  const LoadingState({
    super.nameError = '',
    super.emailError = '',
    super.passwordError = '',
    super.passwordConfirmError = '',
  });
}

class SuccessState extends RegisterState {}

class FailedState extends RegisterState {
  final String message;

  const FailedState({
    required this.message,
    super.nameError = '',
    super.emailError = '',
    super.passwordError = '',
    super.passwordConfirmError = '',
  });

  @override
  List<Object?> get props => [message, ...super.props];
}
