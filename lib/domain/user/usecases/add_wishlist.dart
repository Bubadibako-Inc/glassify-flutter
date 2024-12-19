import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/user/models/wishlist_req_params.dart';
import '../../../service_locator.dart';

import '../repositories/user.dart';

class AddWishlistUseCase extends UseCase<Either, WishlistReqParams> {
  @override
  Future<Either> call({WishlistReqParams? params}) async {
    return await sl<UserRepository>().addWishlist(params!);
  }
}
