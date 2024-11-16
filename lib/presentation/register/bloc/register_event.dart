part of 'register_bloc.dart';

abstract class RegisterEvent {}

class OnButtonPressed extends RegisterEvent {
  final RegisterReqParams params;

  OnButtonPressed({required this.params});
}
