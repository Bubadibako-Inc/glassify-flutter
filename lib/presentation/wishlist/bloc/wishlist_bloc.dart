import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/product/entities/product.dart';
import '../../../domain/product/usecases/get_product_by_id.dart';
import '../../../domain/user/usecases/get_wishlist.dart';
import '../../../service_locator.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoadingState()) {
    on<OnGetWishlist>((event, emit) async {
      emit(WishlistLoadingState());

      final productIds = await sl<GetWishlistUseCase>().call();

      if (productIds.isNotEmpty) {
        List<ProductEntity> products = [];

        for (var i = 0; i < productIds.length; i++) {
          var response =
              await sl<GetProductByIdUseCase>().call(params: productIds[i]);

          response.fold((error) {}, (data) async {
            products.add(data);
          });
        }

        return emit(WishlistLoadedState(products: products));
      } else {
        return emit(WishlistEmptyState());
      }
    });
  }
}
