import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/predict/respositories/predict.dart';
import '../../../service_locator.dart';
import '../models/model_predict_req_params.dart';
import '../sources/predict_api_service.dart';

class PredictRepositoryImpl extends PredictRepository {
  @override
  Future<Either> modelPredict(ModelPredictReqParams params) async {
    final response = await sl<PredictApiService>().modelPredict(params);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final SharedPreferences sharedPref =
            await SharedPreferences.getInstance();
        sharedPref.setString('prediction', data['prediction']);
        return Right(data);
      },
    );
  }

  @override
  Future<bool> isPredicted() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final String? isPredicted = sharedPref.getString('prediction');
    if (isPredicted == null) {
      return false;
    } else {
      return true;
    }
  }
}
