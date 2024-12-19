import 'cart.dart';
import 'wishlist.dart';

class UserEntity {
  UserEntity({
    required this.id,
    required this.cart,
    required this.email,
    required this.name,
    required this.photoProfile,
    required this.role,
    required this.wishlist,
  });

  final String? id;
  final List<CartEntity> cart;
  final String? email;
  final String? name;
  final String? photoProfile;
  final String? role;
  final List<WishlistEntity> wishlist;
}
