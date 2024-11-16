part of 'register_bloc.dart';

abstract class RegisterState {}

class InitialState extends RegisterState {}

class LoadingState extends RegisterState {}

class SuccessState extends RegisterState {}

class FailedState extends RegisterState {
  final String message;
  FailedState({required this.message});
}
