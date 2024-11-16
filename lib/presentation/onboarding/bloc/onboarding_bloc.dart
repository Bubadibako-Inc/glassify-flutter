import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';
part 'onboarding_event.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(InitialState()) {
    on<OnPageChanged>((event, emit) {
      emit(OnboardingState(pageIndex: state.pageIndex = event.pageIndex));
    });
  }
}
