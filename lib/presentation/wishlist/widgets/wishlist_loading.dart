import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/bloc/auth_bloc.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../bloc/wishlist_bloc.dart';

class WishlistLoading extends StatelessWidget {
  const WishlistLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 16.0,
            ),
            child: Shimmer.fromColors(
              baseColor: AppColors.neutral300,
              highlightColor: AppColors.neutral100,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const VerticalSpacer(height: 16),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<AuthBloc>(context).add(GetToken());
                BlocProvider.of<WishlistBloc>(context).add(OnGetWishlist());
              },
              child: GridView.builder(
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: (1 / 1.96),
                ),
                itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: AppColors.neutral300,
                  highlightColor: AppColors.neutral100,
                  child: Container(
                    width: 192,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
