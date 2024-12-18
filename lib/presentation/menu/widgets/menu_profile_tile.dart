import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

class ProfileTile extends StatelessWidget {
  final String name;
  final String email;
  final String avatar;

  const ProfileTile({
    super.key,
    required this.name,
    required this.email,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Ink(
        child: InkWell(
          onTap: () => context.push(AppRoutes.profile),
          splashColor: AppColors.neutral600.withOpacity(0.1),
          hoverColor: AppColors.neutral600.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.amber100,
                  foregroundImage: NetworkImage(
                    avatar,
                  ),
                ),
                const HorizontalSpacer(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
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
}
