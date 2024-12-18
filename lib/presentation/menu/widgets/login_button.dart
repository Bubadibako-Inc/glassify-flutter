import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Material(
        color: AppColors.transparent,
        child: Ink(
          decoration: const BoxDecoration(
            color: AppColors.black,
          ),
          child: InkWell(
            onTap: () => context.push(AppRoutes.login),
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
                'Masuk',
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
    );
  }
}
