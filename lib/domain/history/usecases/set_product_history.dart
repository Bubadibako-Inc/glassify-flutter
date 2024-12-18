import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/history.dart';

class SetProductHistoryUseCase extends UseCase<dynamic, String> {
  @override
  Future<void> call({String? params}) async {
    return await sl<HistoryRepository>().setProductHistory(params!);
  }
}
