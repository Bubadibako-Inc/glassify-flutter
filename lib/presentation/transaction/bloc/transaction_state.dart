part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionLoadingState extends TransactionState {}

class TransactionLoadedState extends TransactionState {
  final List<TransactionEntity> transactions;

  TransactionLoadedState({required this.transactions});
}

class TransactionFailedState extends TransactionState {
  final String message;

  TransactionFailedState({required this.message});
}
