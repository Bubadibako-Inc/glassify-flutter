part of 'payment_result_bloc.dart';

class PaymentResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentResultInitialState extends PaymentResultState {}

class PaymentResultLoadingState extends PaymentResultState {}

class PaymentResultSuccessState extends PaymentResultState {
  final TransactionEntity transaction;

  PaymentResultSuccessState({required this.transaction});
}

class PaymentResultFailedState extends PaymentResultState {
  final String message;

  PaymentResultFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
