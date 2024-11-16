import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/core/configs/assets/app_icons.dart';
import 'package:glassify_flutter/core/configs/theme/app_colors.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;
  late Future<void>
      cameraValue; // This future holds the camera initialization state
  List<File> imagesList = [];
  bool isFlashOn = false;
  bool isRearCamera = true;
  late List<CameraDescription> cameras;
  bool _isInitialized = false; // Flag to check if camera is initialized
  final Dio _dio = Dio();

  // Initialize the camera and set the camera controller
  Future<void> initializeCamera() async {
    cameras = await availableCameras(); // Get available cameras
    startCamera(0); // Initialize the rear camera (0 or 1 based on your setup)
  }

  // Start the camera with the selected index
  void startCamera(int cameraIndex) {
    cameraController = CameraController(
      cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    // Initialize camera and assign it to cameraValue
    cameraValue = cameraController.initialize();
    cameraValue.then((_) {
      setState(() {
        _isInitialized = true;
      });
    }).catchError((error) {
      setState(() {
        _isInitialized = false;
      });
      // Optionally, display an error message to the user
      print("Camera initialization failed: $error");
    });
  }

  // Take a picture
  Future<void> takePicture() async {
    XFile? image;

    if (cameraController.value.isTakingPicture ||
        !cameraController.value.isInitialized) {
      return;
    }

    if (isFlashOn == false) {
      await cameraController.setFlashMode(FlashMode.off);
    } else {
      await cameraController.setFlashMode(FlashMode.torch);
    }

    image = await cameraController.takePicture();

    if (cameraController.value.flashMode == FlashMode.torch) {
      setState(() {
        cameraController.setFlashMode(FlashMode.off);
      });
    }

    final file = await File(image.path);
// Prepare the image as a MultipartFile for uploading
    final formData = FormData.fromMap({
      "face_shape": await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last, // The filename from the file path
      ),
    });

    // Send the image to the server via POST request
    try {
      final response = await _dio.post(
        'http://192.168.1.10:5000/api/users/upload_image',
        data: formData,
      );

      print("Response: ${response.data}");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initializeCamera(); // Initialize the camera on page load
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        body: Center(
            child:
                CircularProgressIndicator()), // Loading indicator while initializing
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // When the camera is initialized, show the camera preview
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: 100,
                        child: CameraPreview(cameraController),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text("Camera initialization failed!"),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                width: double.infinity,
                height: 96,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: AppColors.transparent,
                      shape: const CircleBorder(),
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: AppColors.neutral800,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            setState(() {
                              isFlashOn = !isFlashOn;
                            });
                          },
                          hoverColor: AppColors.neutral200.withOpacity(0.2),
                          splashColor: AppColors.neutral200.withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              isFlashOn == false
                                  ? AppIcons.lightning
                                  : AppIcons.lightningSlash,
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                width: double.infinity,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: AppColors.transparent,
                      shape: const CircleBorder(),
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: AppColors.neutral800,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {},
                          customBorder: const CircleBorder(),
                          hoverColor: AppColors.neutral200.withOpacity(0.2),
                          splashColor: AppColors.neutral200.withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppIcons.fileImage,
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: AppColors.transparent,
                      shape: const CircleBorder(),
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: AppColors.neutral800,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: takePicture,
                          customBorder: const CircleBorder(),
                          hoverColor: AppColors.neutral200.withOpacity(0.2),
                          splashColor: AppColors.neutral200.withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppIcons.aperture,
                              width: 40,
                              height: 40,
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: AppColors.transparent,
                      shape: const CircleBorder(),
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: AppColors.neutral800,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isRearCamera = !isRearCamera;
                            });
                            isRearCamera ? startCamera(0) : startCamera(1);
                          },
                          customBorder: const CircleBorder(),
                          hoverColor: AppColors.neutral200.withOpacity(0.2),
                          splashColor: AppColors.neutral200.withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppIcons.cameraRotate,
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
