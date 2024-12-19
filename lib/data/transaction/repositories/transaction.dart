import 'package:dartz/dartz.dart';

import '../../../common/helper/mapper/transaction_mapper.dart';
import '../../../domain/transaction/repositories/transaction.dart';
import '../../../service_locator.dart';

import '../models/transaction.dart';
import '../models/transaction_req_params.dart';
import '../sources/transaction_api_service.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  @override
  Future<Either> getTransactionById(String id) async {
    var response = await sl<TransactionService>().getTransactionById(id);

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var transaction =
          TransactionMapper.toEntity(TransactionModel.fromJson(data));
      return Right(transaction);
    });
  }

  @override
  Future<Either> getUserTransaction() async {
    var response = await sl<TransactionService>().getUserTransaction();

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var transactions = List.from(data['transactions'])
          .map((item) =>
              TransactionMapper.toEntity(TransactionModel.fromJson(item)))
          .toList();
      return Right(transactions);
    });
  }

  @override
  Future<Either> addTransaction(TransactionReqParams params) async {
    final response = await sl<TransactionService>().addTransaction(params);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }
}
