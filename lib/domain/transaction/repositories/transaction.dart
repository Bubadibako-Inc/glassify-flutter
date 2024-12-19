import 'package:dartz/dartz.dart';

import '../../../data/transaction/models/transaction_req_params.dart';

abstract class TransactionRepository {
  Future<Either> getUserTransaction();
  Future<Either> getTransactionById(String id);
  Future<Either> addTransaction(TransactionReqParams params);
}
