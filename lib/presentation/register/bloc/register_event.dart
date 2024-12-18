part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnButtonPressed extends RegisterEvent {
  final RegisterReqParams params;

  OnButtonPressed({required this.params});
}

class OnNameChanged extends RegisterEvent {
  final String name;

  OnNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class OnEmailChanged extends RegisterEvent {
  final String email;

  OnEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class OnPasswordChanged extends RegisterEvent {
  final String password;

  OnPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class OnPasswordConfirmChanged extends RegisterEvent {
  final String password;
  final String passwordConfirm;

  OnPasswordConfirmChanged(this.password, this.passwordConfirm);

  @override
  List<Object?> get props => [password, passwordConfirm];
}
