part of 'camera_result_bloc.dart';

abstract class CameraResultEvent {}

class OnConfirmPressed extends CameraResultEvent {
  final XFile picture;

  OnConfirmPressed({required this.picture});
}
