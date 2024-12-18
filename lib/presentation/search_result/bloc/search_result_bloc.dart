import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/product/usecases/search_product.dart';
import '../../../domain/product/entities/product.dart';
import '../../../service_locator.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultLoadingState()) {
    on<OnGetSearchResult>((event, emit) async {
      emit(SearchResultLoadingState());

      final response =
          await sl<SearchProductUseCase>().call(params: event.params);

      response.fold((error) {
        emit(SearchResultFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(SearchResultSuccessState(products: data));
      });
    });
  }
}
