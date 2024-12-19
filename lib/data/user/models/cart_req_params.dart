class CartReqParams {
  final String productId;
  final String color;
  final String quantity;

  CartReqParams({
    required this.productId,
    required this.color,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'color': color,
      'quantity': quantity,
    };
  }
}
