import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/auth.dart';

class SetNewcomerUseCase extends UseCase<dynamic, dynamic> {
  @override
  Future<void> call({params}) async {
    return await sl<AuthRepository>().setNewcomer();
  }
}
