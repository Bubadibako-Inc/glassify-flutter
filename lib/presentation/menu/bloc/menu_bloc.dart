import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/auth/usecases/logout.dart';
import '../../../service_locator.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(LogoutInitialState()) {
    on<OnLogoutPressed>((event, emit) async {
      emit(LoadingState());

      final response = await sl<LogoutUseCase>().call();

      response.fold((error) {
        emit(FailedState(message: error ?? 'Terjadi kesalahan'));
      }, (data) async {
        emit(SuccessState());
      });
    });
  }
}
