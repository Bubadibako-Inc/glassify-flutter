import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../service_locator.dart';
import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';

abstract class ProductService {
  Future<Either> getProducts();
  Future<Either> getLatestProducts();
  Future<Either> getBestSellerProducts();
  Future<Either> getProductById(String id);
  Future<Either> getUserWishlist();
  Future<Either> searchProduct(Map<String, dynamic> query);
}

class ProductServiceImpl extends ProductService {
  @override
  Future<Either> getProducts() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.products,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getBestSellerProducts() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.bestSellerProducts,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getLatestProducts() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.latestProducts,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getProductById(String id) async {
    try {
      final response = await sl<DioClient>().get(
        '${ApiUrl.productDetail}/$id',
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getUserWishlist() {
    throw UnimplementedError();
  }

  @override
  Future<Either> searchProduct(Map<String, dynamic> query) async {
    String mapToQueryString(String baseUrl, Map<String, dynamic> params) {
      if (params.isEmpty) return baseUrl;

      final queryString = params.entries
          .where((entry) => entry.value != null) // Filter out null values
          .map((entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
          .join('&');

      return '$baseUrl?${queryString}';
    }

    try {
      final response = await sl<DioClient>().get(
        mapToQueryString(ApiUrl.searchProduct, query),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
