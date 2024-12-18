part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetProduct extends ProductEvent {
  final String params;

  OnGetProduct({required this.params});
}
