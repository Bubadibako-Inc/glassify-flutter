part of 'cart_bloc.dart';

class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartEntity> items;

  CartLoadedState({required this.items});
}

class CartFailedState extends CartState {
  final String message;

  CartFailedState({required this.message});
}
