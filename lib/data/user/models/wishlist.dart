class WishlistModel {
  WishlistModel({
    required this.productId,
  });

  final String? productId;

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      productId: json["product_id"],
    );
  }
}
