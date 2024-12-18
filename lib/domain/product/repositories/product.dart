import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either> getProducts();
  Future<Either> getLatestProducts();
  Future<Either> getBestSellerProducts();
  Future<Either> getProductById(String id);
  Future<Either> searchProduct(Map<String, dynamic> query);
}
