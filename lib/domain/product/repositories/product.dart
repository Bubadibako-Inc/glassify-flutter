import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either> getProducts();
  Future<Either> getProductsByTag();
  Future<Either> searchProductsByName();
  Future<Either> getProductsByCollection();
  Future<Either> getProductById();
  Future<Either> getWishlistProduct();
}
