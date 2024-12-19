part of 'add_wishlist_bloc.dart';

class AddWishlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddWishlistInitialState extends AddWishlistState {}

class AddWishlistLoadingState extends AddWishlistState {}

class AddWishlistSuccessState extends AddWishlistState {}

class AddWishlistFailedState extends AddWishlistState {
  final String message;

  AddWishlistFailedState({required this.message});

  @override
  List<Object?> get props => [message, ...super.props];
}
