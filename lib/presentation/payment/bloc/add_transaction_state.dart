part of 'add_transaction_bloc.dart';

class AddTransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTransactionInitialState extends AddTransactionState {}

class AddTransactionLoadingState extends AddTransactionState {}

class AddTransactionSuccessState extends AddTransactionState {
  final String id;

  AddTransactionSuccessState({required this.id});
}

class AddTransactionFailedState extends AddTransactionState {
  final String message;

  AddTransactionFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
