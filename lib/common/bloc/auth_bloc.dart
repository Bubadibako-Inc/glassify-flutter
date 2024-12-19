import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/auth/usecases/is_authenticated.dart';
import '../../../service_locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<GetToken>((event, emit) async {
      final isAuthenticated = await sl<IsAuthenticatedUseCase>().call();

      if (isAuthenticated != true) {
        return emit(UnauthenticatedState());
      }

      final SharedPreferences _sharedPrefs =
          await SharedPreferences.getInstance();

      final String name = _sharedPrefs.getString('name')!;
      final String email = _sharedPrefs.getString('email')!;
      final String photoProfile = _sharedPrefs.getString('photo_profile')!;

      return emit(AuthenticatedState(
        email: email,
        name: name,
        photoProfile: photoProfile,
      ));
    });
  }
}
