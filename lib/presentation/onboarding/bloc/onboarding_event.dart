part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {}

class OnPageChanged extends OnboardingEvent {
  final int pageIndex;

  OnPageChanged({required this.pageIndex});
}
