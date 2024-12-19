class CartModel {
  CartModel({
    required this.color,
    required this.productId,
    required this.quantity,
  });

  final String? color;
  final String? productId;
  final int? quantity;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      color: json["color"],
      productId: json["product_id"],
      quantity: json["quantity"],
    );
  }
}
