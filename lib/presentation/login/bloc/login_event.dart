part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnEmailChanged extends LoginEvent {
  final String email;

  OnEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class OnPasswordChanged extends LoginEvent {
  final String password;

  OnPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class OnButtonPressed extends LoginEvent {
  final LoginReqParams params;

  OnButtonPressed({required this.params});
}
