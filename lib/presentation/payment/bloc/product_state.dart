part of 'product_bloc.dart';

class PaymentProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentProductLoadingState extends PaymentProductState {}

class PaymentProductSuccessState extends PaymentProductState {
  final ProductEntity product;

  PaymentProductSuccessState({required this.product});
}

class PaymentProductFailedState extends PaymentProductState {
  final String message;

  PaymentProductFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
