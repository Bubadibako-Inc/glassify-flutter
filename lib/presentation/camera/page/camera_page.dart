import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../bloc/camera_bloc.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(OnCameraSetup()),
      child: BlocListener<CameraBloc, CameraState>(
        listener: (_, state) {
          if (state is CameraSuccessState) {
            context.push(AppRoutes.cameraResult, extra: state.picture);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                BlocBuilder<CameraBloc, CameraState>(
                  builder: (context, state) {
                    if (state is CameraInitializedState) {
                      bool isFrontCamera =
                          state.cameraController.description.lensDirection ==
                              CameraLensDirection.front;

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: FittedBox(
                          fit: BoxFit
                              .cover, // or BoxFit.contain, BoxFit.fill depending on your needs
                          child: SizedBox(
                            width: 100,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: isFrontCamera
                                  ? Matrix4.rotationY(math.pi)
                                  : Matrix4
                                      .identity(), // Flip horizontally if front camera
                              child: CameraPreview(state.cameraController),
                            ),
                          ),
                        ),
                      );
                    }

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: AppColors.black,
                    );
                  },
                ),
                BlocBuilder<CameraBloc, CameraState>(
                  builder: (context, state) {
                    return _topOverlay(context);
                  },
                ),
                BlocBuilder<CameraBloc, CameraState>(
                  builder: (context, state) {
                    return _bottomOverlay(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _bottomOverlay(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _pickImageButton(),
            _takePictureButton(context),
            _switchCameraButton(context),
          ],
        ),
      ),
    );
  }

  Material _switchCameraButton(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        decoration: const BoxDecoration(
          color: AppColors.neutral800,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          hoverColor: AppColors.neutral200.withOpacity(0.2),
          splashColor: AppColors.neutral200.withOpacity(0.2),
          onTap: () =>
              BlocProvider.of<CameraBloc>(context).add(OnSwitchCameraPressed()),
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
    );
  }

  Material _takePictureButton(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        decoration: const BoxDecoration(
          color: AppColors.neutral800,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          onTap: () =>
              BlocProvider.of<CameraBloc>(context).add(OnTakePicturePressed()),
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
    );
  }

  Material _pickImageButton() {
    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
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
                AppColors.transparent,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topOverlay(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        width: double.infinity,
        height: 96,
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _backButton(context),
            _toggleFlashButton(context),
          ],
        ),
      ),
    );
  }

  BlocBuilder _toggleFlashButton(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        return Material(
          color: AppColors.transparent,
          shape: const CircleBorder(),
          child: Ink(
            decoration: const BoxDecoration(
              color: AppColors.neutral800,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () =>
                  BlocProvider.of<CameraBloc>(context).add(OnFlashToggled()),
              hoverColor: AppColors.neutral200.withOpacity(0.2),
              splashColor: AppColors.neutral200.withOpacity(0.2),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  BlocProvider.of<CameraBloc>(context).isToggled == false
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
        );
      },
    );
  }

  Material _backButton(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        decoration: const BoxDecoration(
          color: AppColors.neutral800,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => context.pop(),
          hoverColor: AppColors.neutral200.withOpacity(0.2),
          splashColor: AppColors.neutral200.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppIcons.arrowLeft,
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
    );
  }
}
