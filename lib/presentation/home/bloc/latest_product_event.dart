part of 'latest_product_bloc.dart';

abstract class LatestProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetLatestProducts extends LatestProductEvent {}
