import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/transaction/entities/transaction.dart';
import '../../../domain/transaction/usecases/get_user_transaction.dart';
import '../../../service_locator.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionLoadingState()) {
    on<OnGetTransactions>((event, emit) async {
      emit(TransactionLoadingState());

      final response = await sl<GetUserTransactionUseCase>().call();

      response.fold((error) {
        emit(TransactionFailedState(
            message: error ?? 'Terjadi kesalahan silahkan coba lagi nanti'));
      }, (data) {
        emit(TransactionLoadedState(transactions: data));
      });
    });
  }
}
