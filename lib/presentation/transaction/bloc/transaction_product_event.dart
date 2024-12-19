part of 'transaction_product_bloc.dart';

abstract class TransactionProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTransactionProduct extends TransactionProductEvent {
  final String id;

  OnGetTransactionProduct({required this.id});
}
