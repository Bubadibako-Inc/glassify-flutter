part of 'best_seller_product_bloc.dart';

class BestSellerProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BestSellerProductLoadingState extends BestSellerProductState {}

class BestSellerProductSuccessState extends BestSellerProductState {
  final List<ProductEntity> products;

  BestSellerProductSuccessState({required this.products});
}

class BestSellerProductFailedState extends BestSellerProductState {
  final String message;

  BestSellerProductFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
