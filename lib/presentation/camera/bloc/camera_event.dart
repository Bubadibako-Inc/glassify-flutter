part of 'camera_bloc.dart';

abstract class CameraEvent {}

class OnCameraSetup extends CameraEvent {}

class OnTakePicturePressed extends CameraEvent {}

class OnPickImagePressed extends CameraEvent {}

class OnSwitchCameraPressed extends CameraEvent {}

class OnFlashToggled extends CameraEvent {}
