import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:glassify_flutter/data/auth/models/logout_req_params.dart';

import '../../../service_locator.dart';
import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';

import '../models/login_req_params.dart';
import '../models/register_req_params.dart';

abstract class AuthApiService {
  Future<Either> login(LoginReqParams params);
  Future<Either> register(RegisterReqParams params);
  Future<Either> logout(LogoutReqParams params);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> login(LoginReqParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.login,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> register(RegisterReqParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.register,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> logout(LogoutReqParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.register,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
