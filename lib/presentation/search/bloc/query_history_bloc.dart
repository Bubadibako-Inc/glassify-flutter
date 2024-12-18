import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassify_flutter/domain/history/usecases/set_query_history.dart';

import '../../../domain/history/usecases/get_query_history.dart';
import '../../../service_locator.dart';

part 'query_history_event.dart';
part 'query_history_state.dart';

class QueryHistoryBloc extends Bloc<QueryHistoryEvent, QueryHistoryState> {
  QueryHistoryBloc() : super(QueryHistoryLoadingState()) {
    on<OnGetQueryHistory>((event, emit) async {
      List<String> queryHistory = [];

      queryHistory = await sl<GetQueryHistoryUseCase>().call();

      if (queryHistory.isNotEmpty) {
        return emit(QueryHistoryLoadedState(queryHistory: queryHistory));
      } else {
        return emit(QueryHistoryEmptyState());
      }
    });

    on<OnSetQueryHistory>((event, emit) async {
      await sl<SetQueryHistoryUseCase>().call(params: event.query);
    });
  }
}
