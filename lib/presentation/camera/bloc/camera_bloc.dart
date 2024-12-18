import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

part 'camera_state.dart';
part 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  late CameraController _cameraController;
  late List<CameraDescription> cameras;
  bool isToggled = false;
  bool isFront = false;
  int cameraIndex = 0;

  CameraBloc() : super(InitialState()) {
    on<OnCameraSetup>((event, emit) async {
      emit(CameraInitializingState());

      try {
        cameras = await availableCameras();
        if (cameras.isEmpty) {
          emit(CameraFailedState(message: 'No cameras found.'));
          return;
        }

        for (int i = 0; i < cameras.length; i++) {
          if (cameras[i].lensDirection == CameraLensDirection.front) {
            cameraIndex = i;
            break;
          }
        }

        _cameraController = CameraController(
          cameras[cameraIndex],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController.initialize();

        emit(CameraInitializedState(cameraController: _cameraController));
      } catch (e) {
        emit(CameraFailedState(message: e.toString()));
      }
    });

    // Handle Taking Picture
    on<OnTakePicturePressed>((event, emit) async {
      if (_cameraController.value.isTakingPicture ||
          !_cameraController.value.isInitialized) {
        return;
      }

      if (isToggled == false) {
        await _cameraController.setFlashMode(FlashMode.off);
      } else {
        await _cameraController.setFlashMode(FlashMode.torch);
      }

      try {
        XFile picture = await _cameraController.takePicture();

        if (_cameraController.value.flashMode == FlashMode.torch) {
          _cameraController.setFlashMode(FlashMode.off);
        }

        Uint8List imageBytes = await picture.readAsBytes();

        img.Image? image = img.decodeImage(imageBytes);

        if (_cameraController.description.lensDirection ==
            CameraLensDirection.front) {
          image = img.flipHorizontal(image!);
        }

        img.Image rotatedImage = img.copyRotate(image!, angle: 0);

        Uint8List rotatedImageBytes =
            Uint8List.fromList(img.encodeJpg(rotatedImage));

        final directory = await getTemporaryDirectory();

        final filePath =
            '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

        final tempFile = File(filePath);
        await tempFile.writeAsBytes(rotatedImageBytes);

        XFile rotatedPicture = XFile(tempFile.path);

        emit(CameraSuccessState(picture: rotatedPicture));
        emit(CameraInitializedState(cameraController: _cameraController));
      } catch (e) {
        emit(CameraInitializedState(cameraController: _cameraController));
      }
    });

    on<OnPickImagePressed>((event, emit) {
      emit(CameraInitializingState());
    });

    on<OnSwitchCameraPressed>((event, emit) async {
      cameraIndex = (cameraIndex + 1) % cameras.length;
      emit(CameraInitializingState());

      try {
        _cameraController = CameraController(
          cameras[cameraIndex],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController.initialize();
        emit(CameraInitializedState(cameraController: _cameraController));
      } catch (e) {
        emit(CameraFailedState(message: e.toString()));
      }
    });

    on<OnFlashToggled>((event, emit) async {
      if (!_cameraController.value.isInitialized) return;

      isToggled = !isToggled;

      emit(CameraInitializedState(cameraController: _cameraController));
    });
  }

  @override
  Future<void> close() {
    _cameraController.dispose();
    return super.close();
  }
}
