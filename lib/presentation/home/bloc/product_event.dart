part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetProducts extends ProductEvent {}
