import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/product/usecases/get_product_by_id.dart';
import '../../../domain/product/entities/product.dart';
import '../../../service_locator.dart';

part 'product_review_event.dart';
part 'product_review_state.dart';

class ProductBloc extends Bloc<ProductReviewEvent, ProductReviewState> {
  ProductBloc() : super(ProductReviewLoadingState()) {
    on<OnGetReviews>((event, emit) async {
      final response =
          await sl<GetProductByIdUseCase>().call(params: event.params);

      response.fold((error) {
        emit(ProductReviewFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(ProductReviewSuccessState(reviews: data));
      });
    });
  }
}
