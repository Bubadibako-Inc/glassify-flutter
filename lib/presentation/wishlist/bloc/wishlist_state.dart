part of 'wishlist_bloc.dart';

class WishlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedState extends WishlistState {
  final List<ProductEntity> products;

  WishlistLoadedState({required this.products});
}

class WishlistEmptyState extends WishlistState {}
