import 'package:dartz/dartz.dart';
import '../../../service_locator.dart';
import '../repositories/auth.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/auth/models/login_req_params.dart';

class LoginUseCase extends UseCase<Either, LoginReqParams> {
  @override
  Future<Either> call({LoginReqParams? params}) async {
    return await sl<AuthRepository>().login(params!);
  }
}
