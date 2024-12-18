part of 'search_result_bloc.dart';

abstract class SearchResultEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetSearchResult extends SearchResultEvent {
  final Map<String, dynamic> params;

  OnGetSearchResult({required this.params});
}
