import 'package:dartz/dartz.dart';

import '../../../data/predict/models/model_predict_req_params.dart';

abstract class PredictRepository {
  Future<Either> modelPredict(ModelPredictReqParams params);
  Future<bool> isPredicted();
}
