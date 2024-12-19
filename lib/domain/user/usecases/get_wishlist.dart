import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

import '../repositories/user.dart';

class GetWishlistUseCase extends UseCase<List<String>, dynamic> {
  @override
  Future<List<String>> call({params}) async {
    return await sl<UserRepository>().getWishlist();
  }
}
