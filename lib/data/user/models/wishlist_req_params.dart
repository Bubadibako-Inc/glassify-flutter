class WishlistReqParams {
  final String productId;

  WishlistReqParams({
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
    };
  }
}
