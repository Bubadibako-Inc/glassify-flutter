import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/routes/app_routes.dart';

class UnauthenticatedPage extends StatelessWidget {
  const UnauthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AppImages.unauthenticated,
              width: 300,
            ),
            const VerticalSpacer(height: 24),
            const Text(
              'Masuk untuk Memulai Pengalamanmu!',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacer(height: 4),
            const Text(
              'Log in sekarang untuk mengakses semua fitur dan manfaat aplikasi kami. Mudah, cepat, dan aman!',
              style: TextStyle(
                color: AppColors.neutral400,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacer(height: 16),
            Column(
              children: [
                Material(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.black, width: 0.1),
                    ),
                    child: InkWell(
                      splashColor: AppColors.black.withOpacity(0.2),
                      hoverColor: AppColors.black.withOpacity(0.2),
                      onTap: () => context.push(AppRoutes.login),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalSpacer(height: 16),
                Material(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.black, width: 0.1),
                    ),
                    child: InkWell(
                      splashColor: AppColors.neutral300.withOpacity(0.2),
                      hoverColor: AppColors.neutral300.withOpacity(0.2),
                      onTap: () => context.push(AppRoutes.register),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
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
  }
}
