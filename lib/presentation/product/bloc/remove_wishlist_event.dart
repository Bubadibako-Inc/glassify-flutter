part of 'remove_wishlist_bloc.dart';

abstract class RemoveWishlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnRemoveWishlistPressed extends RemoveWishlistEvent {
  final String id;

  OnRemoveWishlistPressed({required this.id});
}
