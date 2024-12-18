part of 'product_bloc.dart';

class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  final ProductEntity product;

  ProductSuccessState({required this.product});
}

class ProductFailedState extends ProductState {
  final String message;

  ProductFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}