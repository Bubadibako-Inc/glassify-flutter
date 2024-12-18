part of 'camera_result_bloc.dart';

abstract class CameraResultState {}

class InitialState extends CameraResultState {}

class LoadingState extends CameraResultState {}

class UploadSuccessState extends CameraResultState {
  final String prediction;

  UploadSuccessState({required this.prediction});
}

class UploadFailedState extends CameraResultState {
  final String message;

  UploadFailedState({required this.message});
}
