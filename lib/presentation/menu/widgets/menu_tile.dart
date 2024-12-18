import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../core/configs/theme/app_colors.dart';

class MenuTile extends StatelessWidget {
  final String icon;
  final Color color;
  final String title;
  final String route;

  const MenuTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.route,
  });

  @override
  Widget build(context) {
    return InkWell(
      onTap: () => context.push(route),
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
              title,
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
