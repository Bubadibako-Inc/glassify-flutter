import 'package:glassify_flutter/domain/history/repositories/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepositoryImpl extends HistoryRepository {
  @override
  Future<List<String>> getProductHistory() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final List<String>? productHistory =
        sharedPref.getStringList('product_history');
    return productHistory ?? [];
  }

  @override
  Future<List<String>> getQueryHistory() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final List<String>? queryHistory =
        sharedPref.getStringList('query_history');
    return queryHistory ?? [];
  }

  @override
  Future<void> setProductHistory(String productId) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();

    List<String>? productHistory =
        sharedPref.getStringList('product_history') ?? [];

    if (productHistory.isEmpty) {
      productHistory = [productId];
    } else {
      if (productHistory.length < 10) {
        productHistory.add(productId);
      } else {
        productHistory.removeAt(0);
      }

      await sharedPref.remove('product_history');
    }
    await sharedPref.setStringList('product_history', productHistory);
  }

  @override
  Future<void> setQueryHistory(String query) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();

    List<String>? queryHistory =
        sharedPref.getStringList('query_history') ?? [];

    if (queryHistory.isEmpty) {
      queryHistory = [query];
    } else {
      if (queryHistory.length < 10) {
        queryHistory.add(query);
      } else {
        queryHistory.removeAt(0);
      }
      await sharedPref.remove('query_history');
    }
    await sharedPref.setStringList('query_history', queryHistory);
  }
}
