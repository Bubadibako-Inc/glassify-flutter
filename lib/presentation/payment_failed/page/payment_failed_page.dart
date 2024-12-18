import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/core/configs/assets/app_images.dart';
import 'package:glassify_flutter/core/configs/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/theme/app_colors.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({super.key});

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(96),
        child: SafeArea(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pembayaran Gagal',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                HorizontalSpacer(width: 16),
                Material(
                  color: AppColors.transparent,
                  shape: const CircleBorder(),
                  child: Ink(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () => context.go(AppRoutes.home),
                      customBorder: const CircleBorder(),
                      hoverColor: AppColors.black.withOpacity(0.2),
                      splashColor: AppColors.black.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          AppIcons.x,
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
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.black,
                width: 0.1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppImages.circleFailed,
                  height: 112,
                  width: 112,
                ),
                VerticalSpacer(height: 16),
                Text(
                  'Pembayaran Gagal!',
                  style: TextStyle(
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                VerticalSpacer(height: 4),
                Text(
                  'Terjadi kesalahan, silahkan coba lagi nanti.',
                  style: TextStyle(
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalSpacer(height: 24),
                Material(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: InkWell(
                      onTap: () => context.go(AppRoutes.home),
                      hoverColor: AppColors.white.withOpacity(0.2),
                      splashColor: AppColors.white.withOpacity(0.2),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: Text(
                          'Kembali ke Beranda',
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
          ),
        ),
      ),
    );
  }
}
