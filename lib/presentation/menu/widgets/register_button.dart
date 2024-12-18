import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Material(
        color: AppColors.transparent,
        child: Ink(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.black,
                width: 0.1,
              )),
          child: InkWell(
            onTap: () => context.push(AppRoutes.register),
            splashColor: AppColors.neutral600.withOpacity(0.2),
            hoverColor: AppColors.neutral600.withOpacity(0.2),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Daftar',
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
    );
  }
}
