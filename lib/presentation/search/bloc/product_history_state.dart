part of 'product_history_bloc.dart';

class ProductHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductHistoryLoadingState extends ProductHistoryState {}

class ProductHistoryEmptyState extends ProductHistoryState {}

class ProductHistoryLoadedState extends ProductHistoryState {
  final List<ProductEntity> productHistory;

  ProductHistoryLoadedState({required this.productHistory});
}
