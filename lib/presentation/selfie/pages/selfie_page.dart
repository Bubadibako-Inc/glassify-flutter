import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:go_router/go_router.dart";

import "../../../core/configs/assets/app_images.dart";
import "../../../core/configs/routes/app_routes.dart";
import "../../../core/configs/theme/app_colors.dart";

import "../../../common/widgets/vertical_spacer.dart";

import "../bloc/selfie_bloc.dart";

class SelfiePage extends StatelessWidget {
  const SelfiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelfieBloc()..add(GetPrediction()),
      child: BlocBuilder<SelfieBloc, SelfieState>(
        builder: (context, state) {
          if (state is PredictedState) {
            return RefreshIndicator(
              color: AppColors.black,
              onRefresh: () async => BlocProvider.of<SelfieBloc>(context).add(
                GetPrediction(),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.black,
                          width: 0.1,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Bentuk wajah kamu adalah',
                            style: TextStyle(
                              color: AppColors.neutral400,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const VerticalSpacer(height: 12),
                          SvgPicture.asset(
                            state.shapeImage,
                            width: 72,
                          ),
                          const VerticalSpacer(height: 12),
                          Text(
                            state.prediction,
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const VerticalSpacer(height: 16),
                          Material(
                            color: AppColors.transparent,
                            child: Ink(
                              decoration: const BoxDecoration(
                                color: AppColors.black,
                              ),
                              child: InkWell(
                                onTap: () => context.go(AppRoutes.camera),
                                splashColor:
                                    AppColors.neutral200.withOpacity(0.2),
                                hoverColor:
                                    AppColors.neutral200.withOpacity(0.2),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: const Text(
                                    'Klasifikasi Ulang',
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
                        ],
                      ),
                    ),
                    const VerticalSpacer(height: 16),
                    const Text(
                      'Rekomendasi Bingkai',
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const VerticalSpacer(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.recommendations.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: index != 0
                              ? const EdgeInsets.only(
                                  top: 12,
                                )
                              : null,
                          child: Material(
                            color: AppColors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            child: Ink(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: InkWell(
                                onTap: () => context.push(
                                  AppRoutes.searchResult,
                                  extra: state.recommendations[index],
                                ),
                                hoverColor: AppColors.black.withOpacity(0.2),
                                splashColor: AppColors.black.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  child: Text(
                                    state.recommendations[index],
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is UnpredictedState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: _defaultPage(context),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Column _defaultPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          AppImages.selfie,
          width: 390,
          alignment: Alignment.center,
        ),
        const VerticalSpacer(height: 8),
        const Text(
          'Rekomendasi Sesuai Bentuk Wajah Kamu',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        const VerticalSpacer(height: 8),
        const Text(
          'Temukan kacamata yang pas untuk wajahmu! Cukup unggah foto wajahmu, dan biarkan aplikasi kami menganalisis bentuk wajahmu untuk memberikan rekomendasi kacamata terbaik yang sesuai dengan gaya dan bentuk wajahmu.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.neutral500,
            fontSize: 14,
          ),
        ),
        const VerticalSpacer(height: 24),
        Material(
          color: AppColors.transparent,
          child: Ink(
            decoration: const BoxDecoration(
              color: AppColors.black,
            ),
            child: InkWell(
              onTap: () => context.push(AppRoutes.camera),
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
                  'Mulai Analisis',
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
      ],
    );
  }
}
