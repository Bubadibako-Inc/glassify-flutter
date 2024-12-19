class TransactionReqParams {
  final String productId;
  final int quantity;

  TransactionReqParams({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "items": [
        {
          "product_id": productId,
          "quantity": quantity,
        }
      ],
    };
  }
}
