abstract class HistoryRepository {
  Future<List<String>> getProductHistory();
  Future<List<String>> getQueryHistory();
  Future<void> setProductHistory(String productId);
  Future<void> setQueryHistory(String query);
}
