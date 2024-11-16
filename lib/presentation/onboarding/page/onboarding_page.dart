import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/theme/app_colors.dart';

import '../../../common/widgets/vertical_spacer.dart';
import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/icon_button.dart';

import '../../../domain/auth/usecases/set_newcomer.dart';

import '../../../service_locator.dart';

import '../bloc/onboarding_bloc.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();

  final List<Map<String, String>> _item = [
    {
      'image': 'assets/images/onboarding_1.svg',
      'title': 'Temukan Gaya Kamu',
      'description':
          'Saatnya upgrade style! Cukup upload foto wajahmu, dan biarkan Glassify nyariin kacamata yang cocok banget sama vibe kamu. Siap tampil kece?',
    },
    {
      'image': 'assets/images/onboarding_2.svg',
      'title': 'Rekomendasi Cerdas',
      'description':
          'Nggak perlu pusing milih kacamata! AI kita bakal nge-review wajahmu dan kasih rekomendasi kacamata yang pas. Cuma dalam beberapa detik, kamu bisa tampil lebih stylish!',
    },
    {
      'image': 'assets/images/onboarding_3.svg',
      'title': 'Belanja Tanpa Ribet',
      'description':
          'Nikmati belanja kacamata dengan santai! Dengan pilihan yang super variatif dan rekomendasi personal, Glassify bikin kamu gampang banget cari kacamata yang bikin kamu makin keren.',
    },
  ];

  void _nextPage(BuildContext context) {
    _pageController.nextPage(
      curve: Curves.ease,
      duration: Durations.medium1,
    );
  }

  void _previousPage(BuildContext context) {
    _pageController.previousPage(
      curve: Curves.ease,
      duration: Durations.medium1,
    );
  }

  void _navigateToHome(BuildContext context) async {
    await sl<SetNewcomerUseCase>().call();
    if (context.mounted) {
      context.go(
        AppRoutes.home,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                return Column(
                  children: [
                    _skipButton(context, state.pageIndex),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _onboarding(context),
                          const VerticalSpacer(height: 32),
                          _buttonRow(context, state.pageIndex),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _onboarding(BuildContext context) {
    return SizedBox(
      height: 412,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => BlocProvider.of<OnboardingBloc>(context).add(
          OnPageChanged(
            pageIndex: index,
          ),
        ),
        itemCount: _item.length,
        itemBuilder: (_, index) => _onboardingItem(_item[index]),
      ),
    );
  }

  SizedBox _buttonRow(BuildContext context, int pageIndex) {
    return SizedBox(
      height: 48,
      child: pageIndex == 0
          ? _nextButton(context, pageIndex)
          : Row(
              children: [
                _backButton(context),
                const HorizontalSpacer(width: 16),
                Expanded(
                  child: _nextButton(context, pageIndex),
                ),
              ],
            ),
    );
  }

  Material _nextButton(BuildContext context, int pageIndex) {
    return Material(
      color: AppColors.transparent,
      child: Ink(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
            color: AppColors.black, borderRadius: BorderRadius.circular(4)),
        child: InkWell(
          onTap: () =>
              pageIndex == 2 ? _navigateToHome(context) : _nextPage(context),
          splashColor: AppColors.neutral600.withOpacity(0.2),
          hoverColor: AppColors.neutral600.withOpacity(0.2),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            child: Text(
              pageIndex == 2 ? 'Selesai' : 'Berikutnya',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppIconButton _backButton(BuildContext context) {
    return AppIconButton(
      onTap: () => _previousPage(context),
      icon: AppIcons.arrowLeft,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      colorFilter: const ColorFilter.mode(
        AppColors.black,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _skipButton(BuildContext context, int pageIndex) {
    if (pageIndex == 2) {
      return const VerticalSpacer(height: 48);
    } else {
      return Container(
        height: 48,
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () => _navigateToHome(context),
          hoverColor: AppColors.neutral600.withOpacity(0.2),
          splashColor: AppColors.neutral600.withOpacity(0.2),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Text(
              'Lewati',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.neutral500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      );
    }
  }

  Column _onboardingItem(Map<String, String> item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          item['image']!,
          width: 390,
        ),
        const VerticalSpacer(height: 8),
        Text(
          item['title']!,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const VerticalSpacer(height: 8),
        Text(
          item['description']!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.neutral500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
