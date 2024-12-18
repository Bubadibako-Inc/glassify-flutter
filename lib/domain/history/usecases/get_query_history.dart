import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/history.dart';

class GetQueryHistoryUseCase extends UseCase<List<String>, dynamic> {
  @override
  Future<List<String>> call({params}) async {
    return await sl<HistoryRepository>().getQueryHistory();
  }
}
