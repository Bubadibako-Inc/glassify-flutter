part of 'onboarding_bloc.dart';

class OnboardingState {
  int pageIndex;
  OnboardingState({required this.pageIndex});
}

class InitialState extends OnboardingState {
  InitialState() : super(pageIndex: 0);
}
