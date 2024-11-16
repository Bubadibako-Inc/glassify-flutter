import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/auth/usecases/is_newcomer.dart';
import '../../../service_locator.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitialState()) {
    on<DisplaySplash>((event, emit) async {
      final isFirstTime = await sl<IsNewcomerUseCase>().call();

      if (isFirstTime != true) {
        return emit(NotFirstTimeState());
      }

      return emit(FirstTimeState());
    });
  }
}
