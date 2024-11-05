import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/theme/app_colors.dart';

import '../models/onboarding_item.dart';

class OnboardingTile extends StatelessWidget {
  const OnboardingTile({
    super.key,
    required this.item,
  });

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          item.image,
          width: 390,
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          style: const TextStyle(
            color: AppColors.black,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.description,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            color: AppColors.neutral500,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
