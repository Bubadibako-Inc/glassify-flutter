import 'package:get_it/get_it.dart';

import '../core/network/dio_client.dart';

import 'data/auth/sources/auth_api_service.dart';
import 'data/auth/repositories/auth.dart';

import 'domain/auth/repositories/auth.dart';
import 'domain/auth/usecases/is_newcomer.dart';
import 'domain/auth/usecases/login.dart';
import 'domain/auth/usecases/set_newcomer.dart';
import 'domain/auth/usecases/is_authenticated.dart';
import 'domain/auth/usecases/register.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase());
  sl.registerSingleton<IsAuthenticatedUseCase>(IsAuthenticatedUseCase());
  sl.registerSingleton<IsNewcomerUseCase>(IsNewcomerUseCase());
  sl.registerSingleton<SetNewcomerUseCase>(SetNewcomerUseCase());
}
