part of 'product_review_bloc.dart';

class ProductReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductReviewLoadingState extends ProductReviewState {}

class ProductReviewSuccessState extends ProductReviewState {
  final List<ProductEntity> reviews;

  ProductReviewSuccessState({required this.reviews});
}

class ProductReviewFailedState extends ProductReviewState {
  final String message;

  ProductReviewFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
