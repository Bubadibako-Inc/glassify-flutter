import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/routes/app_routes.dart';

import '../../../common/widgets/horizontal_spacer.dart';

import '../widgets/empty_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 48,
            bottom: 16,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.black,
                blurRadius: 1,
                blurStyle: BlurStyle.outer,
                spreadRadius: -0.8,
                offset: Offset.zero,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  AppIcons.arrowLeft,
                  height: 24,
                  width: 24,
                  alignment: Alignment.center,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const HorizontalSpacer(width: 16),
              const Text(
                'Keranjang',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push(AppRoutes.wishlist),
                child: SvgPicture.asset(
                  AppIcons.heart,
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: EmptyCart(),
        ),
      ),
    );
  }
}
