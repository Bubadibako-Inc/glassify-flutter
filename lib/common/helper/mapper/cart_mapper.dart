import '../../../data/user/models/cart.dart';
import '../../../domain/user/entities/cart.dart';

class CartMapper {
  static CartEntity toEntity(CartModel cart) {
    return CartEntity(
      productId: cart.productId,
      color: cart.color,
      quantity: cart.quantity,
    );
  }
}
