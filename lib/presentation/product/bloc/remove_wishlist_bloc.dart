import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/user/usecases/delete_wishlist_item.dart';
import '../../../service_locator.dart';

part 'remove_wishlist_event.dart';
part 'remove_wishlist_state.dart';

class RemoveWishlistBloc
    extends Bloc<RemoveWishlistEvent, RemoveWishlistState> {
  RemoveWishlistBloc() : super(RemoveWishlistInitialState()) {
    on<OnRemoveWishlistPressed>((event, emit) async {
      emit(RemoveWishlistInitialState());

      final response =
          await sl<DeleteWishlistItemUseCase>().call(params: event.id);

      response.fold((error) {
        emit(RemoveWishlistFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(RemoveWishlistSuccessState());
      });
    });
  }
}
