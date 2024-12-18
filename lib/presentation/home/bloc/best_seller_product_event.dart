part of 'best_seller_product_bloc.dart';

abstract class BestSellerProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetBestSellerProducts extends BestSellerProductEvent {}
