part of 'latest_product_bloc.dart';

class LatestProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LatestProductLoadingState extends LatestProductState {}

class LatestProductSuccessState extends LatestProductState {
  final List<ProductEntity> products;

  LatestProductSuccessState({required this.products});
}

class LatestProductFailedState extends LatestProductState {
  final String message;

  LatestProductFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
