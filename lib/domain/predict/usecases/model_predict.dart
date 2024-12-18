import 'package:dartz/dartz.dart';

import '../../../data/predict/models/model_predict_req_params.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../respositories/predict.dart';

class ModelPredictUseCase extends UseCase<Either, ModelPredictReqParams> {
  @override
  Future<Either> call({ModelPredictReqParams? params}) async {
    return await sl<PredictRepository>().modelPredict(params!);
  }
}
