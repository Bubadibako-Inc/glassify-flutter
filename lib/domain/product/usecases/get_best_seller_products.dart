import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../../core/usecase/usecase.dart';

import '../repositories/product.dart';

class GetBestSellerProductsUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<ProductRepository>().getBestSellerProducts();
  }
}
