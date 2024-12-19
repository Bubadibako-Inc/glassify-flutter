import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

class TransactionAppbar extends StatelessWidget {
  final bool isPage;

  const TransactionAppbar({
    super.key,
    required this.isPage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColors.black,
              width: 0.1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isPage
                ? Material(
                    color: AppColors.transparent,
                    shape: const CircleBorder(),
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () => context.pop(),
                        customBorder: const CircleBorder(),
                        hoverColor: AppColors.black.withOpacity(0.2),
                        splashColor: AppColors.black.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppIcons.arrowLeft,
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
                  )
                : const SizedBox.shrink(),
            isPage
                ? const HorizontalSpacer(width: 16)
                : const SizedBox.shrink(),
            const Text(
              'Transaksi',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            isPage ? const SizedBox.shrink() : const Spacer(),
            isPage
                ? const SizedBox.shrink()
                : Material(
                    color: AppColors.transparent,
                    shape: const CircleBorder(),
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () => context.go(AppRoutes.menu),
                        customBorder: const CircleBorder(),
                        hoverColor: AppColors.black.withOpacity(0.2),
                        splashColor: AppColors.black.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppIcons.list,
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
                  ),
          ],
        ),
      ),
    );
  }
}
