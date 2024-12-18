import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/configs/assets/app_icons.dart';
import '../../core/configs/theme/app_colors.dart';

import '../widgets/horizontal_spacer.dart';

class ErrorTextField extends StatelessWidget {
  final String text;

  const ErrorTextField({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppIcons.warningCircle,
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            AppColors.red500,
            BlendMode.srcIn,
          ),
        ),
        const HorizontalSpacer(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.red500,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
