part of 'transaction_product_bloc.dart';

class TransactionProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionProductLoadingState extends TransactionProductState {}

class TransactionProductSuccessState extends TransactionProductState {
  final ProductEntity product;

  TransactionProductSuccessState({required this.product});
}

class TransactionProductFailedState extends TransactionProductState {
  final String message;

  TransactionProductFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
