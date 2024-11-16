import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth/models/register_req_params.dart';
import '../../../domain/auth/usecases/register.dart';
import '../../../service_locator.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InitialState()) {
    on<OnButtonPressed>((event, emit) async {
      emit(LoadingState());

      final response = await sl<RegisterUseCase>().call(params: event.params);

      response.fold((error) {
        emit(FailedState(message: error ?? 'Error Brow ada yang salah'));
      }, (data) async {
        emit(SuccessState());
      });
    });
  }
}
