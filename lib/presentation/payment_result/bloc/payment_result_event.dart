part of 'payment_result_bloc.dart';

abstract class PaymentResultEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetPaymentResult extends PaymentResultEvent {
  final String id;

  OnGetPaymentResult({required this.id});
}
