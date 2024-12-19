import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/user/models/cart_req_params.dart';
import '../../../service_locator.dart';

import '../repositories/user.dart';

class AddCartUseCase extends UseCase<Either, CartReqParams> {
  @override
  Future<Either> call({CartReqParams? params}) async {
    return await sl<UserRepository>().addCart(params!);
  }
}
