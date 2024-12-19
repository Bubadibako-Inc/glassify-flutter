import 'package:dartz/dartz.dart';

import '../../../data/user/models/cart_req_params.dart';
import '../../../data/user/models/update_user_req_params.dart';
import '../../../data/user/models/wishlist_req_params.dart';

abstract class UserRepository {
  Future<Either> getUserProfile();
  Future<Either> updateUserById(UpdateUserReqParams params);
  Future<Either> addWishlist(WishlistReqParams params);
  Future<List<String>> getWishlist();
  Future<Either> deleteWishlistItem(String id);
  Future<Either> addCart(CartReqParams params);
  Future<Either> getCart();
  Future<Either> deleteCartItem(String id);
}
