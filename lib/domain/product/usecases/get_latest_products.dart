import 'package:dartz/dartz.dart';
import 'package:glassify_flutter/domain/product/repositories/product.dart';
import '../../../service_locator.dart';
import '../../../core/usecase/usecase.dart';

class GetLatestProductsUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<ProductRepository>().getLatestProducts();
  }
}
