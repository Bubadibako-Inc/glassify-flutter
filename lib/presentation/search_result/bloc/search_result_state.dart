part of 'search_result_bloc.dart';

class SearchResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchResultLoadingState extends SearchResultState {}

class SearchResultSuccessState extends SearchResultState {
  final List<ProductEntity> products;

  SearchResultSuccessState({required this.products});
}

class SearchResultFailedState extends SearchResultState {
  final String message;

  SearchResultFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
