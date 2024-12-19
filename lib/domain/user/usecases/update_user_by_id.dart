import 'package:dartz/dartz.dart';

import '../../../data/user/models/update_user_req_params.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

import '../repositories/user.dart';

class UpdateUserByIdUseCase extends UseCase<Either, UpdateUserReqParams> {
  @override
  Future<Either> call({UpdateUserReqParams? params}) async {
    return await sl<UserRepository>().updateUserById(params!);
  }
}
