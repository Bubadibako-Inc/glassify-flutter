import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth/models/login_req_params.dart';
import '../../../domain/auth/usecases/login.dart';
import '../../../service_locator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    on<OnButtonPressed>((event, emit) async {
      emit(LoadingState());

      final response = await sl<LoginUseCase>().call(params: event.params);

      response.fold((error) {
        emit(FailedState(message: error ?? 'Error Brow ada yang salah'));
      }, (data) async {
        emit(SuccessState());
      });
    });
  }
}
