import 'package:dartz/dartz.dart';

import '../../../common/helper/mapper/product_mapper.dart';
import '../../../domain/product/repositories/product.dart';
import '../../../service_locator.dart';

import '../models/product.dart';
import '../sources/product_api_service.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either> getBestSellerProducts() async {
    var response = await sl<ProductService>().getBestSellerProducts();

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var products = List.from(data['products'])
          .map((item) => ProductMapper.toEntity(ProductModel.fromJson(item)))
          .toList();
      return Right(products);
    });
  }

  @override
  Future<Either> getLatestProducts() async {
    var response = await sl<ProductService>().getLatestProducts();

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var products = List.from(data['products'])
          .map((item) => ProductMapper.toEntity(ProductModel.fromJson(item)))
          .toList();
      return Right(products);
    });
  }

  @override
  Future<Either> getProductById(String id) async {
    var response = await sl<ProductService>().getProductById(id);

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var product = ProductMapper.toEntity(ProductModel.fromJson(data));
      return Right(product);
    });
  }

  @override
  Future<Either> getProducts() async {
    var response = await sl<ProductService>().getProducts();

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var products = List.from(data['products'])
          .map((item) => ProductMapper.toEntity(ProductModel.fromJson(item)))
          .toList();
      return Right(products);
    });
  }

  @override
  Future<Either> searchProduct(Map<String, dynamic> query) async {
    var response = await sl<ProductService>().searchProduct(query);

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var products = List.from(data['products'])
          .map((item) => ProductMapper.toEntity(ProductModel.fromJson(item)))
          .toList();
      return Right(products);
    });
  }
}
