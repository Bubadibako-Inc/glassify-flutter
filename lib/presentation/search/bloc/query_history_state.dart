part of 'query_history_bloc.dart';

class QueryHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QueryHistoryLoadingState extends QueryHistoryState {}

class QueryHistoryEmptyState extends QueryHistoryState {}

class QueryHistoryLoadedState extends QueryHistoryState {
  final List<String> queryHistory;

  QueryHistoryLoadedState({required this.queryHistory});
}
