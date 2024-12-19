import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/product/usecases/get_product_by_id.dart';
import '../../../domain/product/entities/product.dart';
import '../../../service_locator.dart';

part 'transaction_product_event.dart';
part 'transaction_product_state.dart';

class TransactionProductBloc
    extends Bloc<TransactionProductEvent, TransactionProductState> {
  TransactionProductBloc() : super(TransactionProductLoadingState()) {
    on<OnGetTransactionProduct>((event, emit) async {
      final response = await sl<GetProductByIdUseCase>().call(params: event.id);

      response.fold((error) {
        emit(TransactionProductFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(TransactionProductSuccessState(product: data));
      });
    });
  }
}
