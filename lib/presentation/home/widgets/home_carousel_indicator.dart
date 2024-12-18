import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../bloc/carousel_bloc.dart';

// ignore: must_be_immutable
class HomeCarouselIndicator extends StatelessWidget {
  final List<String> images;

  const HomeCarouselIndicator({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        images.length,
        (index) {
          return BlocBuilder<CarouselBloc, CarouselState>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(
                  right: images.length - 1 == index ? 0 : 8,
                ),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: BlocProvider.of<CarouselBloc>(context).state.index ==
                          index
                      ? AppColors.black
                      : AppColors.white,
                  shape: BoxShape.circle,
                  border: BlocProvider.of<CarouselBloc>(context).state.index ==
                          index
                      ? null
                      : Border.all(
                          style: BorderStyle.solid,
                          color: AppColors.black,
                          width: 1,
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
