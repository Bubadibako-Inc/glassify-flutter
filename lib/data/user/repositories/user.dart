import 'package:dartz/dartz.dart';

import '../../../common/helper/mapper/cart_mapper.dart';
import '../../../common/helper/mapper/user_mapper.dart';
import '../../../domain/user/repositories/user.dart';
import '../../../service_locator.dart';

import '../models/cart.dart';
import '../models/cart_req_params.dart';
import '../models/update_user_req_params.dart';
import '../models/user.dart';
import '../models/wishlist_req_params.dart';
import '../sources/user_api_service.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either> addCart(CartReqParams params) async {
    final response = await sl<UserService>().addCart(params);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> addWishlist(WishlistReqParams params) async {
    final response = await sl<UserService>().addWishlist(params);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> deleteCartItem(String id) async {
    final response = await sl<UserService>().deleteCartItem(id);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> deleteWishlistItem(String id) async {
    final response = await sl<UserService>().deleteWishlistItem(id);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getCart() async {
    final response = await sl<UserService>().getCart();
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        var items = List.from(data)
            .map((item) => CartMapper.toEntity(CartModel.fromJson(item)))
            .toList();
        return Right(items);
      },
    );
  }

  @override
  Future<Either> getUserProfile() async {
    final response = await sl<UserService>().getUserProfile();
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        var user = UserMapper.toEntity(UserModel.fromJson(data));
        return Right(user);
      },
    );
  }

  @override
  Future<List<String>> getWishlist() async {
    final response = await sl<UserService>().getWishlist();
    return response.fold(
      (error) {
        return [];
      },
      (data) async {
        var items = List<String>.from(
            data['wishlists'].map((item) => item['product_id'] as String));
        return items;
      },
    );
  }

  @override
  Future<Either> updateUserById(UpdateUserReqParams params) async {
    final response = await sl<UserService>().updateUserById(params);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }
}
