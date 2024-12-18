import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../../../core/usecase/usecase.dart';

import '../repositories/product.dart';

class GetProductByIdUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<ProductRepository>().getProductById(params!);
  }
}
