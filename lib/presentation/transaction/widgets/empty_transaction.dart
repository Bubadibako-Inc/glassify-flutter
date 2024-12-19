import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/theme/app_colors.dart';

import '../../../common/widgets/vertical_spacer.dart';

class EmptyTransaction extends StatelessWidget {
  const EmptyTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.emptyCart,
              width: 390,
            ),
            const VerticalSpacer(height: 16),
            const Text(
              'Transaksi Masih Kosong',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const VerticalSpacer(height: 8),
            const Text(
              'Disini tempat kami menyimpan daftar transaksi pembelianmu, explore lagi yuk!',
              style: TextStyle(
                color: AppColors.neutral500,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
