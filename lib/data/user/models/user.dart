import 'cart.dart';
import 'wishlist.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.cart,
    required this.email,
    required this.name,
    required this.photoProfile,
    required this.role,
    required this.wishlist,
  });

  final String? id;
  final List<CartModel> cart;
  final String? email;
  final String? name;
  final String? photoProfile;
  final String? role;
  final List<WishlistModel> wishlist;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      cart: json["cart"] == null
          ? []
          : List<CartModel>.from(
              json["cart"]!.map((x) => CartModel.fromJson(x))),
      email: json["email"],
      name: json["name"],
      photoProfile: json["photo_profile"],
      role: json["role"],
      wishlist: json["wishlist"] == null
          ? []
          : List<WishlistModel>.from(
              json["wishlist"]!.map((x) => WishlistModel.fromJson(x))),
    );
  }
}
