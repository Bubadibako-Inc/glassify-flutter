part of 'add_wishlist_bloc.dart';

abstract class AddWishlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnAddWishlistPressed extends AddWishlistEvent {
  final WishlistReqParams params;

  OnAddWishlistPressed({required this.params});
}
