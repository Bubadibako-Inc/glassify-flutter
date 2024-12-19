import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:glassify_flutter/data/transaction/models/transaction_req_params.dart';

import '../../../service_locator.dart';
import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';

abstract class TransactionService {
  Future<Either> getUserTransaction();
  Future<Either> getTransactionById(String id);
  Future<Either> addTransaction(TransactionReqParams params);
}

class TransactionServiceImpl extends TransactionService {
  @override
  Future<Either> addTransaction(TransactionReqParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.createTransaction,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either> getTransactionById(String id) async {
    try {
      final response = await sl<DioClient>().get(
        '${ApiUrl.transactionDetail}/$id',
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getUserTransaction() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.userTransaction,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
