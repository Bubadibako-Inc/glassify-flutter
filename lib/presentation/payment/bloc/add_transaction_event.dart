part of 'add_transaction_bloc.dart';

abstract class AddTransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnAddTransactionPressed extends AddTransactionEvent {
  final TransactionReqParams params;

  OnAddTransactionPressed({required this.params});
}
