import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/product/entities/product.dart';
import '../../../domain/product/usecases/get_best_seller_products.dart';

import '../../../service_locator.dart';

part 'best_seller_product_event.dart';
part 'best_seller_product_state.dart';

class BestSellerProductBloc
    extends Bloc<BestSellerProductEvent, BestSellerProductState> {
  BestSellerProductBloc() : super(BestSellerProductLoadingState()) {
    on<OnGetBestSellerProducts>((event, emit) async {
      final response = await sl<GetBestSellerProductsUseCase>().call();

      response.fold((error) {
        emit(BestSellerProductFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(BestSellerProductSuccessState(products: data));
      });
    });
  }
}
