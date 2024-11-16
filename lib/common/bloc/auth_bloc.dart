import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/auth/usecases/is_authenticated.dart';
import '../../../service_locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<GetToken>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));

      final isAuthenticated = await sl<IsAuthenticatedUseCase>().call();

      if (isAuthenticated != true) {
        return emit(UnauthenticatedState());
      }

      return emit(AuthenticatedState());
    });
  }
}
