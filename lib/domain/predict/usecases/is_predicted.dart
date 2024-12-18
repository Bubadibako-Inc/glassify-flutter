import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../respositories/predict.dart';

class IsPredictedUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<PredictRepository>().isPredicted();
  }
}
