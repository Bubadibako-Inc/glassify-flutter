import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/configs/assets/app_icons.dart';
import '../../core/configs/theme/app_colors.dart';

import '../../common/widgets/vertical_spacer.dart';
import '../../common/widgets/horizontal_spacer.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/text_button.dart';
import '../../common/widgets/icon_button.dart';

import '../../onboarding/widgets/onboarding_tile.dart';
import '../../onboarding/models/onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();

  int _activePage = 0;

  void _increment() {
    _pageController.nextPage(
      curve: Curves.ease,
      duration: Durations.medium1,
    );
    setState(() {
      if (_activePage < 2) _activePage++;
    });
  }

  void _decrement() {
    _pageController.previousPage(
      curve: Curves.ease,
      duration: Durations.medium1,
    );
    setState(() {
      if (_activePage > 0) _activePage--;
    });
  }

  void _navigateToHome() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _activePage == 2 ? Container(height: 48) : _buildSkipButton(),
              Container(
                height: 500,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: itemList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (int page) => setState(() {
                    _activePage = page;
                  }),
                  itemBuilder: (BuildContext context, int index) {
                    return OnboardingTile(item: itemList[index]);
                  },
                ),
              ),
              const VerticalSpacer(height: 32),
              _activePage == 0 ? _buildNextButton() : _buildButtonRow(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildButtonRow() {
    return Container(
      height: 48,
      width: double.infinity,
      child: Row(
        children: [
          _buildBackButton(),
          const HorizontalSpacer(width: 16),
          Expanded(
            child: _buildNextButton(),
          ),
        ],
      ),
    );
  }

  AppButton _buildNextButton() {
    return AppButton(
      height: 48,
      width: double.infinity,
      alignment: Alignment.center,
      boxDecoration: const BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      onTap: _activePage == 2 ? _navigateToHome : _increment,
      child: Text(
        _activePage == 2 ? 'Selesai' : 'Berikutnya',
        style: const TextStyle(
          fontFamily: 'SF Pro Display',
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  AppIconButton _buildBackButton() {
    return AppIconButton(
      onTap: _decrement,
      icon: AppIcons.arrowLeft,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      colorFilter: const ColorFilter.mode(
        AppColors.black,
        BlendMode.srcIn,
      ),
    );
  }

  Container _buildSkipButton() {
    return Container(
      height: 48,
      alignment: Alignment.centerRight,
      child: AppTextButton(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        onTap: _navigateToHome,
        text: 'Lewati',
        textStyle: const TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 16,
          color: AppColors.neutral500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
