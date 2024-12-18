import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth/models/login_req_params.dart';
import '../../../domain/auth/usecases/login.dart';
import '../../../service_locator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    on<OnEmailChanged>((event, emit) async {
      final error = event.email.isNotEmpty ? '' : 'Alamat email harus diisi';
      emit(LoginState(
        emailError: error,
        passwordError: state.passwordError,
      ));
    });

    on<OnPasswordChanged>((event, emit) async {
      final error = event.password.isNotEmpty ? '' : 'Password harus diisi';

      emit(LoginState(
        emailError: state.emailError,
        passwordError: error,
      ));
    });

    on<OnButtonPressed>((event, emit) async {
      if (state.emailError.isNotEmpty || state.passwordError.isNotEmpty) {
        emit(FailedState(
          message: 'Pastikan seluruh data sudah terisi.',
          emailError: state.emailError,
          passwordError: state.passwordError,
        ));
        return;
      }

      emit(const LoadingState());

      final response = await sl<LoginUseCase>().call(params: event.params);

      response.fold((error) {
        emit(FailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(SuccessState());
      });
    });
  }
}
