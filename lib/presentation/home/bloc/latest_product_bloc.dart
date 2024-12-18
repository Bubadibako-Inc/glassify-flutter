import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/product/entities/product.dart';
import '../../../domain/product/usecases/get_latest_products.dart';

import '../../../service_locator.dart';

part 'latest_product_event.dart';
part 'latest_product_state.dart';

class LatestProductBloc extends Bloc<LatestProductEvent, LatestProductState> {
  LatestProductBloc() : super(LatestProductLoadingState()) {
    on<OnGetLatestProducts>((event, emit) async {
      final response = await sl<GetLatestProductsUseCase>().call();

      response.fold((error) {
        emit(LatestProductFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(LatestProductSuccessState(products: data));
      });
    });
  }
}
