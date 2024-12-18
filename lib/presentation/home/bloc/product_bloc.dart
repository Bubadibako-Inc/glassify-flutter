import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/product/entities/product.dart';
import '../../../domain/product/usecases/get_products.dart';
import '../../../service_locator.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoadingState()) {
    on<OnGetProducts>((event, emit) async {
      final response = await sl<GetProductsUseCase>().call();

      response.fold((error) {
        emit(ProductFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(ProductSuccessState(products: data));
      });
    });
  }
}
