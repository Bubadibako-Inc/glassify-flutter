import '../../../data/user/models/cart.dart';
import '../../../data/user/models/user.dart';
import '../../../data/user/models/wishlist.dart';
import '../../../domain/user/entities/user.dart';

import 'cart_mapper.dart';
import 'wishlist_mapper.dart';

class UserMapper {
  static UserEntity toEntity(UserModel user) {
    return UserEntity(
      id: user.id,
      email: user.email,
      name: user.name,
      role: user.role,
      photoProfile: user.photoProfile,
      cart: List.from(user.cart)
          .map((item) => CartMapper.toEntity(CartModel.fromJson(item)))
          .toList(),
      wishlist: List.from(user.wishlist)
          .map((item) => WishlistMapper.toEntity(WishlistModel.fromJson(item)))
          .toList(),
    );
  }
}
