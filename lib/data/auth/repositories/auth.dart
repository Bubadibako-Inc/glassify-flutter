import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/auth/repositories/auth.dart';
import '../../../service_locator.dart';

import '../models/login_req_params.dart';
import '../sources/auth_api_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> login(LoginReqParams params) async {
    final response = await sl<AuthApiService>().login(params);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final SharedPreferences sharedPref =
            await SharedPreferences.getInstance();
        sharedPref.setString('token', data['access_token']);
        return Right(data);
      },
    );
  }

  @override
  Future<Either> register(params) async {
    final response = await sl<AuthApiService>().register(params);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final SharedPreferences sharedPref =
            await SharedPreferences.getInstance();
        sharedPref.setString('token', data['access_token']);
        return Right(data);
      },
    );
  }

  @override
  Future<bool> isAuthenticated() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final String? token = sharedPref.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<bool> isNewcomer() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final bool? onboarding = sharedPref.getBool('onboarding');
    if (onboarding == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> setNewcomer() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('onboarding', false);
  }
}