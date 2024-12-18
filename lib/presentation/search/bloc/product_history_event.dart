part of 'product_history_bloc.dart';

abstract class ProductHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetProductHistory extends ProductHistoryEvent {}

class OnSetProductHistory extends ProductHistoryEvent {
  final String id;

  OnSetProductHistory({required this.id});
}
