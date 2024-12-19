import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/transaction/models/transaction_req_params.dart';
import '../../../service_locator.dart';

import '../repositories/transaction.dart';

class CreateTransactionUseCase extends UseCase<Either, TransactionReqParams> {
  @override
  Future<Either> call({TransactionReqParams? params}) async {
    return await sl<TransactionRepository>().addTransaction(params!);
  }
}
