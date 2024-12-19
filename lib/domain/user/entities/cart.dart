class CartEntity {
  CartEntity({
    required this.color,
    required this.productId,
    required this.quantity,
  });

  final String? color;
  final String? productId;
  final int? quantity;
}
