class Item {
  Item({
    required this.price,
    required this.productId,
    required this.quantity,
  });

  final int? price;
  final String? productId;
  final int? quantity;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      price: json["price"],
      productId: json["product_id"],
      quantity: json["quantity"],
    );
  }
}
