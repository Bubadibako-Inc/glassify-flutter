import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/product/usecases/get_product_by_id.dart';
import '../../../domain/product/entities/product.dart';
import '../../../service_locator.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoadingState()) {
    on<OnGetProduct>((event, emit) async {
      final response =
          await sl<GetProductByIdUseCase>().call(params: event.params);

      response.fold((error) {
        emit(ProductFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(ProductSuccessState(product: data));
      });
    });
  }
}
