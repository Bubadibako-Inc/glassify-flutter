import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassify_flutter/domain/transaction/entities/transaction.dart';

import '../../../domain/transaction/usecases/get_transaction_by_id.dart';
import '../../../service_locator.dart';

part 'payment_result_event.dart';
part 'payment_result_state.dart';

class PaymentResultBloc extends Bloc<PaymentResultEvent, PaymentResultState> {
  PaymentResultBloc() : super(PaymentResultInitialState()) {
    on<OnGetPaymentResult>((event, emit) async {
      emit(PaymentResultInitialState());

      final response =
          await sl<GetTransactionByIdUseCase>().call(params: event.id);

      response.fold((error) {
        emit(PaymentResultFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(PaymentResultSuccessState(transaction: data));
      });
    });
  }
}
