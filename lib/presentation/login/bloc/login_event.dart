part of 'login_bloc.dart';

abstract class LoginEvent {}

class OnButtonPressed extends LoginEvent {
  final LoginReqParams params;

  OnButtonPressed({required this.params});
}
