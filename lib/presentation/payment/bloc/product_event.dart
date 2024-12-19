part of 'product_bloc.dart';

abstract class PaymentProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetPaymentProduct extends PaymentProductEvent {
  final String params;

  OnGetPaymentProduct({required this.params});
}
