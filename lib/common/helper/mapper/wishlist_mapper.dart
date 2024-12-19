import '../../../data/user/models/wishlist.dart';
import '../../../domain/user/entities/wishlist.dart';

class WishlistMapper {
  static WishlistEntity toEntity(WishlistModel wishlist) {
    return WishlistEntity(
      productId: wishlist.productId,
    );
  }
}
