import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

import '../models/cart_req_params.dart';
import '../models/update_user_req_params.dart';
import '../models/wishlist_req_params.dart';

abstract class UserService {
  Future<Either> getUserProfile();
  Future<Either> updateUserById(UpdateUserReqParams params);
  Future<Either> addWishlist(WishlistReqParams params);
  Future<Either> getWishlist();
  Future<Either> deleteWishlistItem(String id);
  Future<Either> addCart(CartReqParams params);
  Future<Either> getCart();
  Future<Either> deleteCartItem(String id);
}

class UserServiceImpl extends UserService {
  @override
  Future<Either> addCart(CartReqParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.addItemToCart,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> addWishlist(WishlistReqParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.addWishlist,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> deleteCartItem(String id) async {
    try {
      final response = await sl<DioClient>().delete(
        '${ApiUrl.deleteCartItem}/$id',
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> deleteWishlistItem(String id) async {
    try {
      final response = await sl<DioClient>().delete(
        '${ApiUrl.deleteWishlistItem}/$id',
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getCart() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.getCart,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getUserProfile() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.getUserProfile,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getWishlist() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.getWishlist,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> updateUserById(UpdateUserReqParams params) async {
    try {
      final response = await sl<DioClient>().put(
        ApiUrl.updateUser,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
