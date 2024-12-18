import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth/models/register_req_params.dart';
import '../../../domain/auth/usecases/register.dart';
import '../../../service_locator.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InitialState()) {
    on<OnNameChanged>((event, emit) async {
      final error = event.name.isEmpty ? 'Nama tidak boleh kosong' : '';
      emit(RegisterState(
        nameError: error,
        emailError: state.emailError,
        passwordError: state.passwordError,
        passwordConfirmError: state.passwordConfirmError,
      ));
    });

    on<OnEmailChanged>((event, emit) async {
      final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      final error =
          regex.hasMatch(event.email) ? '' : 'Alamat email tidak valid';
      emit(RegisterState(
        nameError: state.nameError,
        emailError: error,
        passwordError: state.passwordError,
        passwordConfirmError: state.passwordConfirmError,
      ));
    });

    on<OnPasswordChanged>((event, emit) async {
      final regex =
          RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
      final error = regex.hasMatch(event.password)
          ? ''
          : 'Password harus memiliki panjang minimal 8 karakter, mengandung 1 huruf kapital, 1 angka dan 1 karakter spesial';

      emit(RegisterState(
        nameError: state.nameError,
        emailError: state.emailError,
        passwordError: error,
        passwordConfirmError: state.passwordConfirmError,
      ));
    });

    on<OnPasswordConfirmChanged>((event, emit) async {
      final error = event.passwordConfirm != event.password
          ? 'Konfirmasi password harus sama dengan password yang dimasukkan'
          : '';
      emit(RegisterState(
        nameError: state.nameError,
        emailError: state.emailError,
        passwordError: state.passwordError,
        passwordConfirmError: error,
      ));
    });

    on<OnButtonPressed>((event, emit) async {
      if (state.nameError.isNotEmpty ||
          state.emailError.isNotEmpty ||
          state.passwordError.isNotEmpty ||
          state.passwordConfirmError.isNotEmpty) {
        emit(FailedState(
          message: 'Pastikan seluruh data terisi dengan benar.',
          nameError: state.nameError,
          emailError: state.emailError,
          passwordError: state.passwordError,
          passwordConfirmError: state.passwordConfirmError,
        ));
        return;
      }

      emit(const LoadingState());

      final response = await sl<RegisterUseCase>().call(params: event.params);

      response.fold((error) {
        emit(FailedState(
          message: error ?? 'Terjadi kesalahan, coba lagi nanti',
        ));
      }, (data) async {
        emit(SuccessState());
      });
    });
  }
}
