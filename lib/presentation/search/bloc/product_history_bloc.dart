import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassify_flutter/domain/history/usecases/set_product_history.dart';
import 'package:glassify_flutter/domain/product/entities/product.dart';
import 'package:glassify_flutter/domain/product/usecases/get_product_by_id.dart';

import '../../../domain/history/usecases/get_product_history.dart';
import '../../../service_locator.dart';

part 'product_history_event.dart';
part 'product_history_state.dart';

class ProductHistoryBloc
    extends Bloc<ProductHistoryEvent, ProductHistoryState> {
  ProductHistoryBloc() : super(ProductHistoryLoadingState()) {
    on<OnGetProductHistory>((event, emit) async {
      List<String> productHistory = [];

      productHistory = await sl<GetProductHistoryUseCase>().call();

      if (productHistory.isNotEmpty) {
        List<ProductEntity> productEntities = [];

        for (var i = 0; i < productHistory.length; i++) {
          var response =
              await sl<GetProductByIdUseCase>().call(params: productHistory[i]);

          response.fold((error) {}, (data) async {
            productEntities.add(data);
          });
        }

        return emit(ProductHistoryLoadedState(productHistory: productEntities));
      } else {
        return emit(ProductHistoryEmptyState());
      }
    });

    on<OnSetProductHistory>((event, emit) async {
      await sl<SetProductHistoryUseCase>().call(params: event.id);
    });
  }
}
