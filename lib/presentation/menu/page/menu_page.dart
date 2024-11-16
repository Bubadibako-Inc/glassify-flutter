import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  final List<String> _menuItems = [
    'Wishlist',
    'Daftar Transaksi',
    'Daftar Ulasan',
    'Pengaturan',
    'Log out',
  ];

  final List<String> _menuIcons = [
    AppIcons.heart,
    AppIcons.receipt,
    AppIcons.star,
    AppIcons.gear,
    AppIcons.signOut,
  ];

  final List<String> _menuRoutes = [
    'Wishlist',
    'Daftar Transaksi',
    'Daftar Ulasan',
    'Pengaturan',
    'Log out',
  ];

  final List<Color> _menuColors = [
    AppColors.black,
    AppColors.black,
    AppColors.black,
    AppColors.black,
    AppColors.red600,
  ];

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
              const Text(
                'Menu',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  AppIcons.x,
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _profile(),
              _menu(context),
              const VerticalSpacer(height: 4),
              _divider(),
              const VerticalSpacer(height: 8),
              _loginButton(context),
              const VerticalSpacer(height: 12),
              _registerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding _registerButton(BuildContext context) {
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

  Padding _loginButton(BuildContext context) {
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

  Padding _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Divider(
        thickness: 2,
        color: AppColors.neutral300,
      ),
    );
  }

  Column _menu(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        _menuItems.length,
        (index) {
          return _menuTile(
            context: context,
            icon: _menuIcons[index],
            text: _menuItems[index],
            route: _menuRoutes[index],
            color: _menuColors[index],
          );
        },
      ),
    );
  }

  Material _profile() {
    return Material(
      color: AppColors.transparent,
      child: Ink(
        child: InkWell(
          onTap: () {},
          splashColor: AppColors.neutral600.withOpacity(0.1),
          hoverColor: AppColors.neutral600.withOpacity(0.1),
          child: const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  radius: 36,
                  foregroundImage: NetworkImage(
                    'https://images.pexels.com/photos/27603433/pexels-photo-27603433/free-photo-of-mode-fashion-fesyen-wanita.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  ),
                ),
                HorizontalSpacer(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Fadly Nugraha Jati',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '(+62) 813-9219-2034',
                        style: TextStyle(
                          color: AppColors.neutral400,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'fadlynj@glassify.com',
                        style: TextStyle(
                          color: AppColors.neutral400,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell _menuTile({
    required BuildContext context,
    required String icon,
    required String text,
    required String route,
    required Color color,
  }) {
    return InkWell(
      onTap: () => print(route),
      splashColor: AppColors.neutral600.withOpacity(0.1),
      hoverColor: AppColors.neutral600.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              alignment: Alignment.center,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
            const HorizontalSpacer(width: 16),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
