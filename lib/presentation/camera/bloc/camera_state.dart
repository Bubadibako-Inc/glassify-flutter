part of 'camera_bloc.dart';

abstract class CameraState {}

class InitialState extends CameraState {}

class CameraInitializingState extends CameraState {}

class CameraInitializedState extends CameraState {
  final CameraController cameraController;

  CameraInitializedState({required this.cameraController});
}

class CameraSuccessState extends CameraState {
  final XFile picture;

  CameraSuccessState({required this.picture});
}

class CameraFailedState extends CameraState {
  final String message;

  CameraFailedState({required this.message});
}
