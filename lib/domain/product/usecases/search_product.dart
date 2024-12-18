import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../../core/usecase/usecase.dart';

import '../repositories/product.dart';

class SearchProductUseCase extends UseCase<Either, Map<String, dynamic>> {
  @override
  Future<Either> call({Map<String, dynamic>? params}) async {
    return await sl<ProductRepository>().searchProduct(params!);
  }
}
