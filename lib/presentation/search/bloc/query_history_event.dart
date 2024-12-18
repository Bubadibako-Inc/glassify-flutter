part of 'query_history_bloc.dart';

abstract class QueryHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetQueryHistory extends QueryHistoryEvent {}

class OnSetQueryHistory extends QueryHistoryEvent {
  final String query;

  OnSetQueryHistory({required this.query});
}
