part of 'menu_bloc.dart';

abstract class MenuState {}

class LogoutInitialState extends MenuState {}

class LoadingState extends MenuState {}

class SuccessState extends MenuState {}

class FailedState extends MenuState {
  final String message;

  FailedState({required this.message});
}
