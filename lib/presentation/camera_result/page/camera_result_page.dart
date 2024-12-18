import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/common/widgets/horizontal_spacer.dart';
import 'package:glassify_flutter/common/widgets/vertical_spacer.dart';
import 'package:glassify_flutter/presentation/selfie/bloc/selfie_bloc.dart'
    as selfie;
import 'package:go_router/go_router.dart';

import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/routes/app_routes.dart';

import '../bloc/camera_result_bloc.dart';

class CameraResultPage extends StatelessWidget {
  final XFile picture;
  const CameraResultPage({super.key, required this.picture});

  Future<void> _showErrorDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Terjadi Kesalahan',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const VerticalSpacer(height: 12),
                Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const VerticalSpacer(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: AppColors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.black,
                            width: 0.1,
                          ),
                        ),
                        child: InkWell(
                          splashColor: AppColors.black.withOpacity(0.2),
                          hoverColor: AppColors.black.withOpacity(0.2),
                          onTap: () {
                            context.pop();
                            context.pop();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 24,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Ambil Gambar Lagi',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    HorizontalSpacer(width: 12),
                    Material(
                      color: AppColors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.black,
                          // border: Border.all(
                          //   color: AppColors.black,
                          //   width: 0.1,
                          // ),
                        ),
                        child: InkWell(
                          splashColor: AppColors.neutral300.withOpacity(0.2),
                          hoverColor: AppColors.neutral300.withOpacity(0.2),
                          onTap: () {
                            context.pop();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 24,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Mendeteksi Wajah',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                VerticalSpacer(height: 16),
                CircularProgressIndicator(
                  color: AppColors.black,
                  strokeWidth: 4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CameraResultBloc(),
        ),
        BlocProvider(
          create: (context) => selfie.SelfieBloc(),
        ),
      ],
      child: BlocConsumer<CameraResultBloc, CameraResultState>(
        listener: (context, state) {
          if (state is LoadingState) {
            _showLoadingDialog(context);
          }

          if (state is UploadFailedState) {
            context.pop();
            _showErrorDialog(context, state.message);
          }

          if (state is UploadSuccessState) {
            BlocProvider.of<selfie.SelfieBloc>(context).add(
              selfie.UpdatePrediction(prediction: state.prediction),
            );
            // context.go(AppRoutes.home, extra: 1);
            context.go(AppRoutes.home);
          }
        },
        builder: (context, _) {
          return Scaffold(
            backgroundColor: AppColors.black,
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.file(
                        File(picture.path),
                      ),
                    ),
                  ),
                  _topOverlay(context),
                  _bottomOverlay(context),
                ],
              ),
            ),
          );
        },
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
            _cancelButton(context),
            _confirmButton(context),
          ],
        ),
      ),
    );
  }

  Material _confirmButton(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          onTap: () => BlocProvider.of<CameraResultBloc>(context).add(
            OnConfirmPressed(
              picture: picture,
            ),
          ),
          customBorder: const CircleBorder(),
          hoverColor: AppColors.neutral800.withOpacity(0.2),
          splashColor: AppColors.neutral800.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppIcons.check,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Material _cancelButton(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        decoration: const BoxDecoration(
          color: AppColors.neutral800,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          onTap: () => context.pop(),
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
              AppIcons.x,
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

  Align _topOverlay(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _backButton(context),
          ],
        ),
      ),
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
