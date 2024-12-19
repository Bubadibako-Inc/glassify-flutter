part of 'remove_wishlist_bloc.dart';

class RemoveWishlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RemoveWishlistInitialState extends RemoveWishlistState {}

class RemoveWishlistLoadingState extends RemoveWishlistState {}

class RemoveWishlistSuccessState extends RemoveWishlistState {}

class RemoveWishlistFailedState extends RemoveWishlistState {
  final String message;

  RemoveWishlistFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
