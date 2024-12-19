import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../../core/usecase/usecase.dart';

import '../repositories/transaction.dart';

class GetTransactionByIdUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<TransactionRepository>().getTransactionById(params!);
  }
}
