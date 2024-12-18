part of 'product_review_bloc.dart';

abstract class ProductReviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetReviews extends ProductReviewEvent {
  final String params;

  OnGetReviews({required this.params});
}
