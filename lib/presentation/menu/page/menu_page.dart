import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/presentation/menu/bloc/menu_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../common/bloc/auth_bloc.dart';
import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';

import '../widgets/login_button.dart';
import '../widgets/menu_appbar.dart';
import '../widgets/menu_profile_tile.dart';
import '../widgets/menu_tile.dart';
import '../widgets/register_button.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: BlocProvider(
              create: (context) => MenuBloc(),
              child: BlocListener<MenuBloc, MenuState>(
                listener: (context, state) {
                  if (state is SuccessState) {
                    context.pop();
                    context.pop();
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Keluar Akun',
                      style: TextStyle(
                        color: AppColors.red500,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const VerticalSpacer(height: 12),
                    BlocBuilder<MenuBloc, MenuState>(
                      builder: (context, state) {
                        if (state is FailedState) {
                          return Text(
                            state.message,
                            style: const TextStyle(
                              color: AppColors.neutral500,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          );
                        }

                        if (state is LoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                              strokeWidth: 4,
                            ),
                          );
                        }

                        return const Text(
                          'Apakah anda yakin ingin keluar dari akun ini?',
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                    const VerticalSpacer(height: 16),
                    BlocBuilder<MenuBloc, MenuState>(
                      builder: (context, state) {
                        if (state is LogoutInitialState) {
                          return Row(
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
                                    splashColor:
                                        AppColors.black.withOpacity(0.2),
                                    hoverColor:
                                        AppColors.black.withOpacity(0.2),
                                    onTap: () => context.pop(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 24,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Batalkan',
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
                              const HorizontalSpacer(width: 12),
                              Material(
                                color: AppColors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.red500,
                                  ),
                                  child: InkWell(
                                    splashColor:
                                        AppColors.neutral300.withOpacity(0.2),
                                    hoverColor:
                                        AppColors.neutral300.withOpacity(0.2),
                                    onTap: () {
                                      BlocProvider.of<MenuBloc>(context).add(
                                        OnLogoutPressed(),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 24,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Keluar dari Akun',
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
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(96),
        child: MenuAppbar(),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc()..add(GetToken()),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthenticatedState) {
                  final List<Map<String, dynamic>> _menuItems = [
                    {
                      'name': 'Wishlist',
                      'icon': AppIcons.heart,
                      'color': AppColors.black,
                      'route': AppRoutes.wishlist,
                    },
                    {
                      'name': 'Daftar Transaksi',
                      'icon': AppIcons.receipt,
                      'color': AppColors.black,
                      'route': AppRoutes.transaction,
                    },
                    {
                      'name': 'Daftar Ulasan',
                      'icon': AppIcons.star,
                      'color': AppColors.black,
                      'route': AppRoutes.review,
                    },
                    {
                      'name': 'Tentang Aplikasi',
                      'icon': AppIcons.warningCircle,
                      'color': AppColors.black,
                      'route': AppRoutes.about,
                    },
                  ];

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ProfileTile(
                        name: state.name,
                        email: state.email,
                        avatar: state.role,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          _menuItems.length,
                          (index) {
                            return MenuTile(
                              title: _menuItems[index]['name'],
                              icon: _menuItems[index]['icon'],
                              color: _menuItems[index]['color'],
                              route: _menuItems[index]['route'],
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () => _showLogoutDialog(context),
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
                                AppIcons.signOut,
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.red600,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const HorizontalSpacer(width: 16),
                              const Text(
                                'Logout',
                                style: TextStyle(
                                  color: AppColors.red600,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                if (state is UnauthenticatedState) {
                  final List<Map<String, dynamic>> _menuItems = [
                    {
                      'name': 'Pengaturan',
                      'icon': AppIcons.gear,
                      'color': AppColors.black,
                      'route': AppRoutes.about,
                    },
                  ];

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const VerticalSpacer(height: 24),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          _menuItems.length,
                          (index) {
                            return MenuTile(
                              title: _menuItems[index]['name'],
                              icon: _menuItems[index]['icon'],
                              color: _menuItems[index]['color'],
                              route: _menuItems[index]['route'],
                            );
                          },
                        ),
                      ),
                      const VerticalSpacer(height: 4),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider(
                          thickness: 2,
                          color: AppColors.neutral300,
                        ),
                      ),
                      const VerticalSpacer(height: 8),
                      const LoginButton(),
                      const VerticalSpacer(height: 12),
                      const RegisterButton(),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
