import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../bloc/carousel_bloc.dart';

// ignore: must_be_immutable
class HomeCarousel extends StatelessWidget {
  final PageController pageController;
  final List<String> images;

  const HomeCarousel({
    super.key,
    required this.pageController,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColors.black,
            width: 0.1,
          ),
        ),
        child: PageView.builder(
          pageSnapping: true,
          controller: pageController,
          itemCount: images.length,
          onPageChanged: (index) {
            BlocProvider.of<CarouselBloc>(context).add(
              OnPageChanged(index: index),
            );
          },
          itemBuilder: (_, index) {
            return CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
              placeholder: (_, __) {
                return Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16,
                  ),
                  child: SvgPicture.asset(
                    AppImages.imagePlaceholder,
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
