import 'package:dartz/dartz.dart';

import '../../../data/auth/models/login_req_params.dart';
import '../../../data/auth/models/register_req_params.dart';

abstract class AuthRepository {
  Future<Either> login(LoginReqParams params);
  Future<Either> register(RegisterReqParams params);
  Future<bool> isAuthenticated();
  Future<bool> isNewcomer();
  Future setNewcomer();
}
