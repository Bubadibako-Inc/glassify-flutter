part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTransactions extends TransactionEvent {}
