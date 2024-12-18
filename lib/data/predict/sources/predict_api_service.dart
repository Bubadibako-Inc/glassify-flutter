import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:glassify_flutter/data/predict/models/model_predict_req_params.dart';

import '../../../service_locator.dart';
import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';

abstract class PredictApiService {
  Future<Either> modelPredict(ModelPredictReqParams params);
}

class PredictApiServiceImpl extends PredictApiService {
  @override
  Future<Either> modelPredict(ModelPredictReqParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.predict,
        data: await params.toFormData(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
