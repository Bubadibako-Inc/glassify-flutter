import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/transaction/models/transaction_req_params.dart';
import '../../../domain/transaction/usecases/create_transaction.dart';
import '../../../service_locator.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc() : super(AddTransactionInitialState()) {
    on<OnAddTransactionPressed>((event, emit) async {
      emit(AddTransactionInitialState());

      final response =
          await sl<CreateTransactionUseCase>().call(params: event.params);

      response.fold((error) {
        emit(AddTransactionFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(AddTransactionSuccessState(
          id: data['_id'].toString(),
        ));
      });
    });
  }
}
