part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetWishlist extends WishlistEvent {}