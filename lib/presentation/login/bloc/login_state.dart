part of 'login_bloc.dart';

abstract class LoginState {}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class FailedState extends LoginState {
  final String message;

  FailedState({required this.message});
}
