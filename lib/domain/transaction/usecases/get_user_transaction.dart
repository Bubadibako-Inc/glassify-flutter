import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../../core/usecase/usecase.dart';

import '../repositories/transaction.dart';

class GetUserTransactionUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<TransactionRepository>().getUserTransaction();
  }
}
