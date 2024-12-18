// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../bloc/navbar_bloc.dart';

class HomeNavbar extends StatefulWidget {
  final List<String> inactiveIcons;
  final List<String> activeIcons;

  const HomeNavbar({
    super.key,
    required this.inactiveIcons,
    required this.activeIcons,
  });

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.activeIcons.length,
          (index) {
            return BlocBuilder<NavbarBloc, NavbarState>(
              builder: (context, state) {
                return Material(
                  color: AppColors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<NavbarBloc>(context).add(
                        OnPageChanged(index: index),
                      );
                    },
                    customBorder: const CircleBorder(),
                    hoverColor: AppColors.neutral600.withOpacity(0.2),
                    splashColor: AppColors.neutral600.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        BlocProvider.of<NavbarBloc>(context).state.index ==
                                index
                            ? widget.activeIcons[index]
                            : widget.inactiveIcons[index],
                        width: 28,
                        height: 28,
                        colorFilter: const ColorFilter.mode(
                          AppColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
