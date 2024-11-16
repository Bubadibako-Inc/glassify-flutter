import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:go_router/go_router.dart";

import "../../../core/configs/assets/app_images.dart";
import "../../../core/configs/routes/app_routes.dart";
import "../../../core/configs/theme/app_colors.dart";

import "../../../common/widgets/vertical_spacer.dart";

class SelfiePage extends StatelessWidget {
  const SelfiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            AppImages.selfie,
            width: 390,
            alignment: Alignment.center,
          ),
          const VerticalSpacer(height: 8),
          const Text(
            'Rekomendasi Sesuai Bentuk Wajah Kamu',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const VerticalSpacer(height: 8),
          const Text(
            'Temukan kacamata yang pas untuk wajahmu! Cukup unggah foto wajahmu, dan biarkan aplikasi kami menganalisis bentuk wajahmu untuk memberikan rekomendasi kacamata terbaik yang sesuai dengan gaya dan bentuk wajahmu.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.neutral500,
              fontSize: 14,
            ),
          ),
          const VerticalSpacer(height: 24),
          Material(
            color: AppColors.transparent,
            child: Ink(
              decoration: const BoxDecoration(
                color: AppColors.black,
              ),
              child: InkWell(
                onTap: () => context.push(AppRoutes.camera),
                splashColor: AppColors.neutral200.withOpacity(0.2),
                hoverColor: AppColors.neutral200.withOpacity(0.2),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: const Text(
                    'Mulai Analisis',
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
    );
  }
}
