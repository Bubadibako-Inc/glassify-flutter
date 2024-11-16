import '../../../core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../repositories/auth.dart';

class IsAuthenticatedUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isAuthenticated();
  }
}
